using System.Collections;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Metadata;

namespace System.Runtime.Remoting;

[ComVisible(true)]
public class SoapServices
{
	private class TypeInfo
	{
		public Hashtable Attributes;

		public Hashtable Elements;
	}

	private static Hashtable _xmlTypes = new Hashtable();

	private static Hashtable _xmlElements = new Hashtable();

	private static Hashtable _soapActions = new Hashtable();

	private static Hashtable _soapActionsMethods = new Hashtable();

	private static Hashtable _typeInfos = new Hashtable();

	public static string XmlNsForClrTypeWithAssembly => "http://schemas.microsoft.com/clr/assem/";

	public static string XmlNsForClrTypeWithNs => "http://schemas.microsoft.com/clr/ns/";

	public static string XmlNsForClrTypeWithNsAndAssembly => "http://schemas.microsoft.com/clr/nsassem/";

	public static string CodeXmlNamespaceForClrTypeNamespace(string typeNamespace, string assemblyName)
	{
		if (assemblyName == string.Empty)
		{
			return XmlNsForClrTypeWithNs + typeNamespace;
		}
		if (typeNamespace == string.Empty)
		{
			return EncodeNs(XmlNsForClrTypeWithAssembly + assemblyName);
		}
		return EncodeNs(XmlNsForClrTypeWithNsAndAssembly + typeNamespace + "/" + assemblyName);
	}

	private static string GetNameKey(string name, string namspace)
	{
		if (namspace == null)
		{
			return name;
		}
		return name + " " + namspace;
	}

	private static string GetAssemblyName(MethodBase mb)
	{
		if (mb.DeclaringType.Assembly == typeof(object).Assembly)
		{
			return string.Empty;
		}
		return mb.DeclaringType.Assembly.GetName().Name;
	}

	public static bool GetXmlElementForInteropType(Type type, out string xmlElement, out string xmlNamespace)
	{
		SoapTypeAttribute soapTypeAttribute = (SoapTypeAttribute)InternalRemotingServices.GetCachedSoapAttribute(type);
		if (!soapTypeAttribute.IsInteropXmlElement)
		{
			xmlElement = null;
			xmlNamespace = null;
			return false;
		}
		xmlElement = soapTypeAttribute.XmlElementName;
		xmlNamespace = soapTypeAttribute.XmlNamespace;
		return true;
	}

	public static string GetXmlNamespaceForMethodCall(MethodBase mb)
	{
		return CodeXmlNamespaceForClrTypeNamespace(mb.DeclaringType.FullName, GetAssemblyName(mb));
	}

	public static string GetXmlNamespaceForMethodResponse(MethodBase mb)
	{
		return CodeXmlNamespaceForClrTypeNamespace(mb.DeclaringType.FullName, GetAssemblyName(mb));
	}

	public static bool GetXmlTypeForInteropType(Type type, out string xmlType, out string xmlTypeNamespace)
	{
		SoapTypeAttribute soapTypeAttribute = (SoapTypeAttribute)InternalRemotingServices.GetCachedSoapAttribute(type);
		if (!soapTypeAttribute.IsInteropXmlType)
		{
			xmlType = null;
			xmlTypeNamespace = null;
			return false;
		}
		xmlType = soapTypeAttribute.XmlTypeName;
		xmlTypeNamespace = soapTypeAttribute.XmlTypeNamespace;
		return true;
	}

	public static void PreLoad(Assembly assembly)
	{
		Type[] types = assembly.GetTypes();
		for (int i = 0; i < types.Length; i++)
		{
			PreLoad(types[i]);
		}
	}

	public static void PreLoad(Type type)
	{
		TypeInfo typeInfo = _typeInfos[type] as TypeInfo;
		if (typeInfo != null)
		{
			return;
		}
		if (GetXmlTypeForInteropType(type, out var xmlType, out var xmlTypeNamespace))
		{
			RegisterInteropXmlType(xmlType, xmlTypeNamespace, type);
		}
		if (GetXmlElementForInteropType(type, out xmlType, out xmlTypeNamespace))
		{
			RegisterInteropXmlElement(xmlType, xmlTypeNamespace, type);
		}
		lock (_typeInfos.SyncRoot)
		{
			typeInfo = new TypeInfo();
			FieldInfo[] fields = type.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			foreach (FieldInfo fieldInfo in fields)
			{
				SoapFieldAttribute soapFieldAttribute = (SoapFieldAttribute)InternalRemotingServices.GetCachedSoapAttribute(fieldInfo);
				if (!soapFieldAttribute.IsInteropXmlElement())
				{
					continue;
				}
				string nameKey = GetNameKey(soapFieldAttribute.XmlElementName, soapFieldAttribute.XmlNamespace);
				if (soapFieldAttribute.UseAttribute)
				{
					if (typeInfo.Attributes == null)
					{
						typeInfo.Attributes = new Hashtable();
					}
					typeInfo.Attributes[nameKey] = fieldInfo;
				}
				else
				{
					if (typeInfo.Elements == null)
					{
						typeInfo.Elements = new Hashtable();
					}
					typeInfo.Elements[nameKey] = fieldInfo;
				}
			}
			_typeInfos[type] = typeInfo;
		}
	}

	public static void RegisterInteropXmlElement(string xmlElement, string xmlNamespace, Type type)
	{
		lock (_xmlElements.SyncRoot)
		{
			_xmlElements[xmlElement + " " + xmlNamespace] = type;
		}
	}

	public static void RegisterInteropXmlType(string xmlType, string xmlTypeNamespace, Type type)
	{
		lock (_xmlTypes.SyncRoot)
		{
			_xmlTypes[xmlType + " " + xmlTypeNamespace] = type;
		}
	}

	private static string EncodeNs(string ns)
	{
		ns = ns.Replace(",", "%2C");
		ns = ns.Replace(" ", "%20");
		return ns.Replace("=", "%3D");
	}
}

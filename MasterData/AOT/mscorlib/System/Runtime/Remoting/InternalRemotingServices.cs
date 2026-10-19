using System.Collections;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Metadata;

namespace System.Runtime.Remoting;

[ComVisible(true)]
public class InternalRemotingServices
{
	private static Hashtable _soapAttributes = new Hashtable();

	public static SoapAttribute GetCachedSoapAttribute(object reflectionObject)
	{
		lock (_soapAttributes.SyncRoot)
		{
			SoapAttribute soapAttribute = _soapAttributes[reflectionObject] as SoapAttribute;
			if (soapAttribute != null)
			{
				return soapAttribute;
			}
			object[] customAttributes = ((ICustomAttributeProvider)reflectionObject).GetCustomAttributes(typeof(SoapAttribute), inherit: true);
			if (customAttributes.Length != 0)
			{
				soapAttribute = (SoapAttribute)customAttributes[0];
			}
			else if (reflectionObject is Type)
			{
				soapAttribute = new SoapTypeAttribute();
			}
			else if (reflectionObject is FieldInfo)
			{
				soapAttribute = new SoapFieldAttribute();
			}
			else if (reflectionObject is MethodBase)
			{
				soapAttribute = new SoapMethodAttribute();
			}
			else if (reflectionObject is ParameterInfo)
			{
				soapAttribute = new SoapParameterAttribute();
			}
			soapAttribute.SetReflectionObject(reflectionObject);
			_soapAttributes[reflectionObject] = soapAttribute;
			return soapAttribute;
		}
	}
}

using System.Collections;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Threading;

namespace System.ComponentModel;

[ComVisible(true)]
public abstract class MemberDescriptor
{
	private string name;

	private string displayName;

	private int nameHash;

	private AttributeCollection attributeCollection;

	private Attribute[] attributes;

	private Attribute[] originalAttributes;

	private bool attributesFiltered;

	private bool attributesFilled;

	private int metadataVersion;

	private string category;

	private string description;

	private object lockCookie = new object();

	protected virtual Attribute[] AttributeArray
	{
		get
		{
			CheckAttributesValid();
			FilterAttributesIfNeeded();
			return attributes;
		}
		set
		{
			lock (lockCookie)
			{
				attributes = value;
				originalAttributes = value;
				attributesFiltered = false;
				attributeCollection = null;
			}
		}
	}

	public virtual AttributeCollection Attributes
	{
		get
		{
			CheckAttributesValid();
			AttributeCollection attributeCollection = this.attributeCollection;
			if (attributeCollection == null)
			{
				lock (lockCookie)
				{
					attributeCollection = (this.attributeCollection = CreateAttributeCollection());
				}
			}
			return attributeCollection;
		}
	}

	public virtual string Name
	{
		get
		{
			if (name == null)
			{
				return "";
			}
			return name;
		}
	}

	protected virtual int NameHashCode => nameHash;

	public virtual string DisplayName
	{
		get
		{
			if (!(Attributes[typeof(DisplayNameAttribute)] is DisplayNameAttribute displayNameAttribute) || displayNameAttribute.IsDefaultAttribute())
			{
				return displayName;
			}
			return displayNameAttribute.DisplayName;
		}
	}

	protected MemberDescriptor(string name, Attribute[] attributes)
	{
		try
		{
			if (name == null || name.Length == 0)
			{
				throw new ArgumentException(global::SR.GetString("Invalid member name."));
			}
			this.name = name;
			displayName = name;
			nameHash = name.GetHashCode();
			if (attributes != null)
			{
				this.attributes = attributes;
				attributesFiltered = false;
			}
			originalAttributes = this.attributes;
		}
		catch (Exception ex)
		{
			throw ex;
		}
	}

	protected MemberDescriptor(MemberDescriptor oldMemberDescriptor, Attribute[] newAttributes)
	{
		name = oldMemberDescriptor.Name;
		displayName = oldMemberDescriptor.DisplayName;
		nameHash = name.GetHashCode();
		ArrayList arrayList = new ArrayList();
		if (oldMemberDescriptor.Attributes.Count != 0)
		{
			foreach (object attribute in oldMemberDescriptor.Attributes)
			{
				arrayList.Add(attribute);
			}
		}
		if (newAttributes != null)
		{
			foreach (object value in newAttributes)
			{
				arrayList.Add(value);
			}
		}
		attributes = new Attribute[arrayList.Count];
		arrayList.CopyTo(attributes, 0);
		attributesFiltered = false;
		originalAttributes = attributes;
	}

	private void CheckAttributesValid()
	{
		if (attributesFiltered && metadataVersion != TypeDescriptor.MetadataVersion)
		{
			attributesFilled = false;
			attributesFiltered = false;
			attributeCollection = null;
		}
	}

	protected virtual AttributeCollection CreateAttributeCollection()
	{
		return new AttributeCollection(AttributeArray);
	}

	public override bool Equals(object obj)
	{
		if (this == obj)
		{
			return true;
		}
		if (obj == null)
		{
			return false;
		}
		if (obj.GetType() != GetType())
		{
			return false;
		}
		MemberDescriptor memberDescriptor = (MemberDescriptor)obj;
		FilterAttributesIfNeeded();
		memberDescriptor.FilterAttributesIfNeeded();
		if (memberDescriptor.nameHash != nameHash)
		{
			return false;
		}
		if (memberDescriptor.category == null != (category == null) || (category != null && !memberDescriptor.category.Equals(category)))
		{
			return false;
		}
		if (!System.LocalAppContextSwitches.MemberDescriptorEqualsReturnsFalseIfEquivalent)
		{
			if (memberDescriptor.description == null != (description == null) || (description != null && !memberDescriptor.description.Equals(description)))
			{
				return false;
			}
		}
		else if (memberDescriptor.description == null != (description == null) || (description != null && !memberDescriptor.category.Equals(description)))
		{
			return false;
		}
		if (memberDescriptor.attributes == null != (attributes == null))
		{
			return false;
		}
		bool result = true;
		if (attributes != null)
		{
			if (attributes.Length != memberDescriptor.attributes.Length)
			{
				return false;
			}
			for (int i = 0; i < attributes.Length; i++)
			{
				if (!attributes[i].Equals(memberDescriptor.attributes[i]))
				{
					result = false;
					break;
				}
			}
		}
		return result;
	}

	protected virtual void FillAttributes(IList attributeList)
	{
		if (originalAttributes != null)
		{
			Attribute[] array = originalAttributes;
			foreach (Attribute value in array)
			{
				attributeList.Add(value);
			}
		}
	}

	private void FilterAttributesIfNeeded()
	{
		if (attributesFiltered)
		{
			return;
		}
		IList list;
		if (!attributesFilled)
		{
			list = new ArrayList();
			try
			{
				FillAttributes(list);
			}
			catch (ThreadAbortException)
			{
				throw;
			}
			catch (Exception)
			{
			}
		}
		else
		{
			list = new ArrayList(attributes);
		}
		Hashtable hashtable = new Hashtable(list.Count);
		foreach (Attribute item in list)
		{
			hashtable[item.TypeId] = item;
		}
		Attribute[] array = new Attribute[hashtable.Values.Count];
		hashtable.Values.CopyTo(array, 0);
		lock (lockCookie)
		{
			attributes = array;
			attributesFiltered = true;
			attributesFilled = true;
			metadataVersion = TypeDescriptor.MetadataVersion;
		}
	}

	protected static MethodInfo FindMethod(Type componentClass, string name, Type[] args, Type returnType)
	{
		return FindMethod(componentClass, name, args, returnType, publicOnly: true);
	}

	protected static MethodInfo FindMethod(Type componentClass, string name, Type[] args, Type returnType, bool publicOnly)
	{
		MethodInfo methodInfo = null;
		methodInfo = ((!publicOnly) ? componentClass.GetMethod(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic, null, args, null) : componentClass.GetMethod(name, args));
		if (methodInfo != null && !methodInfo.ReturnType.IsEquivalentTo(returnType))
		{
			methodInfo = null;
		}
		return methodInfo;
	}

	public override int GetHashCode()
	{
		return nameHash;
	}

	protected virtual object GetInvocationTarget(Type type, object instance)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (instance == null)
		{
			throw new ArgumentNullException("instance");
		}
		return TypeDescriptor.GetAssociation(type, instance);
	}

	protected static ISite GetSite(object component)
	{
		if (!(component is IComponent))
		{
			return null;
		}
		return ((IComponent)component).Site;
	}
}

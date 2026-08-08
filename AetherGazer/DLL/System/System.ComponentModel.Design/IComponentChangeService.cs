namespace System.ComponentModel.Design;

public interface IComponentChangeService
{
	void OnComponentChanged(object component, MemberDescriptor member, object oldValue, object newValue);

	void OnComponentChanging(object component, MemberDescriptor member);
}

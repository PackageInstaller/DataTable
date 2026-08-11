namespace Ase.ECS;

public interface IPropertyChangedBefore
{
	void OnPropertyChangedBefore(string propertyName, PropertyChangedEnum changedEnum, float delta);
}

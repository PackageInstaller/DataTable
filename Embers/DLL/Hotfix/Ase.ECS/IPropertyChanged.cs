namespace Ase.ECS;

public interface IPropertyChanged
{
	void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta);
}

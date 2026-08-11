namespace Ase.ECS;

public interface IPropertyEstimatedChanged
{
	void OnPropertyEstimatedChanged(string propertyName, PropertyChangedEnum changedEnum, float delta);
}

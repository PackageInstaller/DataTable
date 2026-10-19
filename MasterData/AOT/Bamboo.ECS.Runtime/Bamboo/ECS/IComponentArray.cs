namespace Bamboo.ECS;

internal interface IComponentArray
{
	object GetObject(int index);

	void AddObject(object component);

	void RemoveAtSwapBack(int index);
}

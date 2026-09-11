public interface IEntityShape
{
	ISimShape GetShape();

	void SetEnable(bool isEnable);

	Int3 GetOffset();

	int GetWeight();

	int GetPart();

	Int GetRadius();

	uint GetLayer();
}

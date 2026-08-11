namespace UnityEngine.Rendering;

public interface IBitArray
{
	uint capacity { get; }

	bool allFalse { get; }

	bool allTrue { get; }

	bool this[uint index] { get; set; }

	string humanizedData { get; }

	IBitArray BitAnd(IBitArray other);

	IBitArray BitOr(IBitArray other);

	IBitArray BitNot();
}

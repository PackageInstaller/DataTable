using Config;

public interface IEntityBuff
{
	int mBuffConfigID { get; set; }

	BuffStatusType mBuffType { get; set; }

	int mDuring { get; set; }

	int mTick { get; set; }

	int mCount { get; set; }

	bool mAlreadyApplied { get; set; }

	EBuffLife mBindLife { get; set; }
}

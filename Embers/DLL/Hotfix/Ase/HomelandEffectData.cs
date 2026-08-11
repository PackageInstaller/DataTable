namespace Ase;

public class HomelandEffectData
{
	private int id;

	private float curVal;

	public float CurVal => curVal;

	public HomelandEffectData(DRHomeLandLevelEffect effect)
	{
		id = effect.Id;
		curVal = effect.InitValue;
	}

	public void SetVal(float val)
	{
		curVal = val;
	}
}

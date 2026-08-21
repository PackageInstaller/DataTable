using System.Collections.Generic;
using Ase;
using GameFramework;

public class SingleBattleFrameMessage : IReference
{
	public string ParadoxParamKey;

	public int ParadoxParamValue;

	public int Tick;

	public int Actor;

	public List<float> inputUV;

	public int optionCode;

	public List<float> skillJoyUv;

	public int SkillState;

	public bool AutoFight;

	public bool AutoUseProp;

	public static SingleBattleFrameMessage Create(bool isFromPool = true)
	{
		SingleBattleFrameMessage obj = ((!isFromPool) ? new SingleBattleFrameMessage() : (Singleton<ObjectPool>.Instance.Fetch(typeof(SingleBattleFrameMessage)) as SingleBattleFrameMessage));
		obj.inputUV = new List<float>();
		obj.skillJoyUv = new List<float>();
		return obj;
	}

	public void Clear()
	{
		inputUV.Clear();
		skillJoyUv.Clear();
	}
}

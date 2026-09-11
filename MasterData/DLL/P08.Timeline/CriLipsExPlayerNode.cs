using P08.CriLipsEx;
using UnityEngine;
using UnityEngine.Playables;

public class CriLipsExPlayerNode : PlayableAsset
{
	private CriLipsExCueData criLipsExCueData;

	public string pSheetName = "vo_sys_1084";

	public string pCueName = "v_s_1084_greet2";

	public double defaultDuration
	{
		get
		{
			if (criLipsExCueData != null && criLipsExCueData.m_criLipsExFrameDatas != null)
			{
				int num = criLipsExCueData.m_criLipsExFrameDatas.Length;
				if (num > 0)
				{
					return (float)num * 0.0333f;
				}
			}
			return 1.0;
		}
	}

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<CriLipsExPlayerNodePlayable> scriptPlayable = ScriptPlayable<CriLipsExPlayerNodePlayable>.Create(graph);
		criLipsExCueData = CriLipsExAtom.GetCueSheet(pSheetName, pCueName);
		CriLipsExPlayerNodePlayable behaviour = scriptPlayable.GetBehaviour();
		if (behaviour != null)
		{
			behaviour.criLipsExCueData = criLipsExCueData;
		}
		return scriptPlayable;
	}
}

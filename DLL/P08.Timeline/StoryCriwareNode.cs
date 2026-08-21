using System;
using System.Collections.Generic;
using System.ComponentModel;
using Google.Protobuf.Collections;
using NetProcol;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("开始播放区间")]
public class StoryCriwareNode : PlayableAsset
{
	public bool m_isComboSkillAsset;

	public string mCueSheet;

	public string mCueName;

	public string mCueAcb;

	public string mCueAwb;

	public int mCueId;

	public bool mUseStream;

	public bool mIsVoice;

	public bool mAutoPlayEnd;

	public bool mIsMusic;

	public bool m_useRandom;

	public List<int> m_weightList = new List<int>();

	public List<CriCueInfo> m_criCueInfoList = new List<CriCueInfo>();

	public bool mLoopIfPlaying;

	public bool mMarried;

	public CriCueInfo mCriCueInfoOfMarried = new CriCueInfo();

	[HideInInspector]
	public double CueLength = -1.0;

	public override double duration
	{
		get
		{
			if (CueLength == -1.0)
			{
				UpdateCueLength();
			}
			if (CueLength == -1.0)
			{
				return 1.0;
			}
			return CueLength;
		}
	}

	public void UpdateCueLength()
	{
	}

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryCriwareNodeBehaviour> scriptPlayable = ScriptPlayable<StoryCriwareNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().mCueSheet = mCueSheet;
		scriptPlayable.GetBehaviour().mCueName = mCueName;
		scriptPlayable.GetBehaviour().mUseStream = mUseStream;
		scriptPlayable.GetBehaviour().mIsVoice = mIsVoice;
		scriptPlayable.GetBehaviour().mAutoPlayEnd = mAutoPlayEnd;
		scriptPlayable.GetBehaviour().mIsMusic = mIsMusic;
		scriptPlayable.GetBehaviour().m_isComboSkillAsset = m_isComboSkillAsset;
		scriptPlayable.GetBehaviour().mLoopIfPlaying = mLoopIfPlaying;
		if (m_useRandom)
		{
			int num = 0;
			for (int i = 0; i < m_weightList.Count; i++)
			{
				num += m_weightList[i];
			}
			if (num > 0)
			{
				int num2 = UnityEngine.Random.Range(0, num);
				for (int j = 0; j < m_weightList.Count; j++)
				{
					if (num2 < m_weightList[j])
					{
						scriptPlayable.GetBehaviour().mCueSheet = m_criCueInfoList[j].mCueSheet;
						scriptPlayable.GetBehaviour().mCueName = m_criCueInfoList[j].mCueName;
						scriptPlayable.GetBehaviour().mUseStream = m_criCueInfoList[j].mUseStream;
						break;
					}
					num2 -= m_weightList[j];
				}
			}
		}
		if (mIsVoice && mMarried && NScene.GetCurrentScene() is BattleScene)
		{
			BattleScene obj = NScene.GetCurrentScene() as BattleScene;
			RepeatedField<RoleDataForExchangeInfo> roleDataInLua = ((BattleScene)NScene.GetCurrentScene()).ready.SceneDataForExcehange.RoleDataInLua;
			if (obj != null && roleDataInLua.Count > 0 && roleDataInLua.get_Item(0).IsVow)
			{
				scriptPlayable.GetBehaviour().mCueSheet = mCriCueInfoOfMarried.mCueSheet;
				scriptPlayable.GetBehaviour().mCueName = mCriCueInfoOfMarried.mCueName;
				scriptPlayable.GetBehaviour().mUseStream = mCriCueInfoOfMarried.mUseStream;
			}
		}
		return scriptPlayable;
	}
}

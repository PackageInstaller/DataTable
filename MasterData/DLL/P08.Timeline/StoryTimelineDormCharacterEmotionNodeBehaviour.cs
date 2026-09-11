using Dorm;
using Dorm.Character;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;
using UnityEngine.Playables;

public class StoryTimelineDormCharacterEmotionNodeBehaviour : StoryTimelineDormCharacterBehaviour
{
	public int actorIndex;

	public bool isSpecial;

	public string efxFacePath;

	public int sheetFaceId;

	public bool isRevert;

	private GameObject m_actor_go;

	private PlayerCharacterFaceControl m_player_fc;

	private SDCharacter m_sdcharacter;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
	}

	protected override void Enter()
	{
		if (!DormStoryManager.instance.hasInited)
		{
			return;
		}
		GameObject actorGoByIndex = DormStoryManager.instance.GetActorGoByIndex(actorIndex);
		if (actorGoByIndex != null)
		{
			m_player_fc = actorGoByIndex.GetComponent<PlayerCharacterFaceControl>();
			m_sdcharacter = actorGoByIndex.GetComponent<SDCharacter>();
		}
		if (!(m_sdcharacter == null))
		{
			m_sdcharacter.sheetFaceId = sheetFaceId;
			if (!((Object)(object)m_player_fc == null) && !string.IsNullOrEmpty(efxFacePath) && isSpecial)
			{
				m_player_fc.PlaySpecialFaceExpression(efxFacePath, 99999f);
			}
		}
	}

	protected override void Exit()
	{
		if (!isRevert || m_sdcharacter == null)
		{
			return;
		}
		m_sdcharacter.sheetFaceId = 0;
		if (!((Object)(object)m_player_fc == null) && isSpecial)
		{
			m_player_fc.UseNormalFace();
			if (m_player_fc.curEfxFace != null)
			{
				DormStoryManager.instance.DestroyGo(m_player_fc.curEfxFace.gameObject);
			}
		}
	}
}

using System.Collections.Generic;
using T0World;
using UnityEngine.Playables;

namespace Oath;

public class OathCaptureCharacterLogic : T0CaptureCharacterLogic
{
	public new OathCaptureContext context => OathSceneLoader.Scene.context.captureManager.captureContext;

	public override PlayableDirector playable
	{
		get
		{
			if (m_playable == null)
			{
				m_playable = context.modelObj.GetComponent<PlayableDirector>();
				if (m_playable == null)
				{
					m_playable = context.modelObj.AddComponent<PlayableDirector>();
				}
			}
			return m_playable;
		}
	}

	public override void PlayFaceTimeline(string faceName)
	{
		PlayableAsset playableAsset = Asset.Load<PlayableAsset>(OathConst.GetFaceAssetPath(OathSceneLoader.Scene.context.characterID, faceName));
		playable.Stop();
		playable.playableAsset = playableAsset;
		IEnumerator<PlayableBinding> enumerator = playable.playableAsset.outputs.GetEnumerator();
		while (enumerator.MoveNext())
		{
			PlayableBinding current = enumerator.Current;
			_ = current.streamName;
			playable.SetGenericBinding(current.sourceObject, base.faceBindObj);
		}
		playable.extrapolationMode = DirectorWrapMode.None;
		playable.Play();
		playable.Evaluate();
	}
}

using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class DestinySubViewBase : MonoBehaviour
{
	public class DestinyInfo
	{
		private readonly bool _originalActive;

		public int Id { get; }

		public int Index { get; }

		public bool Active { get; set; }

		public bool Add
		{
			get
			{
				if (Active)
				{
					return !_originalActive;
				}
				return false;
			}
		}

		public bool Remove
		{
			get
			{
				if (!Active)
				{
					return _originalActive;
				}
				return false;
			}
		}

		public DestinyInfo(int id, bool active, int index)
		{
			Id = id;
			Index = index;
			_originalActive = active;
			Active = active;
		}

		public bool SetActive(bool active)
		{
			if (Active == active)
			{
				return false;
			}
			Active = active;
			return true;
		}
	}

	[Tooltip("1命对应显示的元素")]
	public List<GameObject> stage1;

	[Tooltip("2命对应显示的元素")]
	public List<GameObject> stage2;

	[Tooltip("3命对应显示的元素")]
	public List<GameObject> stage3;

	[Tooltip("4命对应显示的元素")]
	public List<GameObject> stage4;

	[Tooltip("5命对应显示的元素")]
	public List<GameObject> stage5;

	[Tooltip("6命对应显示的元素")]
	public List<GameObject> stage6;

	[Tooltip("额外命座1对应显示的元素")]
	public List<GameObject> extraStage1;

	[Tooltip("额外命座2对应显示的元素")]
	public List<GameObject> extraStage2;

	[FormerlySerializedAs("betterAnimation")]
	public Animator anim;

	public List<Image> rgbChangesMats;

	public Material initMaterial;

	public SkeletonGraphic spineCharacter;

	public string spineAnimationName = "idle";

	[Range(0f, 2f)]
	public float spineTimeScale = 1f;

	[HideInInspector]
	public int currentSelectedDestinyId = -1;

	public void InitEveryStageShows(ref Dictionary<int, List<GameObject>> everyStageShows)
	{
		if (everyStageShows == null)
		{
			everyStageShows = new Dictionary<int, List<GameObject>>();
		}
		everyStageShows[0] = stage1;
		everyStageShows[1] = stage2;
		everyStageShows[2] = stage3;
		everyStageShows[3] = stage4;
		everyStageShows[4] = stage5;
		everyStageShows[5] = stage6;
		everyStageShows[6] = extraStage1;
		everyStageShows[7] = extraStage2;
	}

	public void ControlSpineAnimation(bool play)
	{
		if (spineCharacter == null)
		{
			return;
		}
		if (spineCharacter.AnimationState == null || spineCharacter.Skeleton == null)
		{
			spineCharacter.Initialize(overwrite: true);
		}
		Spine.AnimationState animationState = spineCharacter.AnimationState;
		if (play)
		{
			spineCharacter.timeScale = spineTimeScale;
			animationState.ClearTrack(0);
			animationState.SetAnimation(0, spineAnimationName, loop: true);
			return;
		}
		spineCharacter.timeScale = 1f;
		animationState.ClearTracks();
		if (spineCharacter.Skeleton == null)
		{
			spineCharacter.Initialize(overwrite: true);
		}
		spineCharacter.Skeleton.SetToSetupPose();
		spineCharacter.Update(0f);
	}

	public void InitDestinyInfo()
	{
		foreach (Image rgbChangesMat in rgbChangesMats)
		{
			rgbChangesMat.material = initMaterial;
		}
	}

	private void OnValidate()
	{
		if (anim == null)
		{
			anim = GetComponentInChildren<Animator>();
		}
	}
}

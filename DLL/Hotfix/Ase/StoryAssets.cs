using System.Collections.Generic;
using Sirenix.OdinInspector;
using Spine.Unity;
using UnityEngine;

namespace Ase;

[CreateAssetMenu(fileName = "StoryAssets", menuName = "剧情/资源集", order = 1)]
public class StoryAssets : SerializedScriptableObject
{
	[Header("Background Resources")]
	public Dictionary<string, Sprite> backgroundSprites = new Dictionary<string, Sprite>();

	[Header("Spine Resources")]
	public Dictionary<string, SkeletonGraphic> spineAnimations = new Dictionary<string, SkeletonGraphic>();

	[Header("Fmod Sound Resources")]
	public Dictionary<string, string> fmodSoundPaths = new Dictionary<string, string>();

	[Header("Effect Resources")]
	public Dictionary<string, StoryEffect> effectResources = new Dictionary<string, StoryEffect>();

	[Header("AnimatorPrefab Resources")]
	public Dictionary<string, Animator> animatorResources = new Dictionary<string, Animator>();
}

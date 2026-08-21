using System;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "StoryOverlayAnimationConfig", menuName = "ScriptableObjects/StoryOverlayAnimationConfig", order = 1)]
public class StoryOverlayAnimationConfig : SerializedScriptableObject
{
	public Dictionary<string, AnimationClip> animationClips = new Dictionary<string, AnimationClip>();

	public Dictionary<string, AvatarMask> avatarMasks = new Dictionary<string, AvatarMask>();
}

using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public struct QwLodData
{
	public float distance;

	public float lastDistance;

	public bool loaded;

	public bool visible;

	public bool positionDirty;

	public bool distanceDirty;

	public bool modelDirty;

	public bool visibilityDirty;

	public int lodObjectIndex;

	public Bounds bounds;

	public float boundSphereRadius;

	public List<Renderer> renderers;

	public List<DynamicBone> dynamicBones;

	public List<Animator> animators;

	public List<ParticleSystem> particleSystems;

	public QWCharacterPassController passController;

	public Transform npcShadow;
}

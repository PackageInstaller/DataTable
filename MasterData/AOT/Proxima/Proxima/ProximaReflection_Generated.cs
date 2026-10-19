using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Animations;
using UnityEngine.Audio;
using UnityEngine.EventSystems;
using UnityEngine.Playables;
using UnityEngine.Rendering;
using UnityEngine.U2D;
using UnityEngine.UI;
using UnityEngine.UIElements;
using UnityEngine.Video;

namespace Proxima;

internal static class ProximaReflection_Generated
{
	public static Dictionary<string, ProximaComponentCommands.PropertyInfo[]> Properties = new Dictionary<string, ProximaComponentCommands.PropertyInfo[]>
	{
		{
			"UnityEngine.Animations.AimConstraint",
			new ProximaComponentCommands.PropertyInfo[12]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "constraintActive",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).constraintActive = (bool)v;
					},
					Getter = (object o) => ((AimConstraint)o).constraintActive,
					Updater = delegate(object o, ref object v)
					{
						bool constraintActive = ((AimConstraint)o).constraintActive;
						if (!constraintActive.Equals((bool)v))
						{
							v = constraintActive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "weight",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).weight = (float)v;
					},
					Getter = (object o) => ((AimConstraint)o).weight,
					Updater = delegate(object o, ref object v)
					{
						float weight = ((AimConstraint)o).weight;
						if (!weight.Equals((float)v))
						{
							v = weight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "aimVector",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).aimVector = (Vector3)v;
					},
					Getter = (object o) => ((AimConstraint)o).aimVector,
					Updater = delegate(object o, ref object v)
					{
						Vector3 aimVector = ((AimConstraint)o).aimVector;
						if (!aimVector.Equals((Vector3)v))
						{
							v = aimVector;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "upVector",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).upVector = (Vector3)v;
					},
					Getter = (object o) => ((AimConstraint)o).upVector,
					Updater = delegate(object o, ref object v)
					{
						Vector3 upVector = ((AimConstraint)o).upVector;
						if (!upVector.Equals((Vector3)v))
						{
							v = upVector;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "worldUpType",
					PropertyType = typeof(AimConstraint.WorldUpType),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).worldUpType = (AimConstraint.WorldUpType)v;
					},
					Getter = (object o) => ((AimConstraint)o).worldUpType,
					Updater = delegate(object o, ref object v)
					{
						int worldUpType = (int)((AimConstraint)o).worldUpType;
						if (!worldUpType.Equals((int)v))
						{
							v = worldUpType;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "worldUpVector",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).worldUpVector = (Vector3)v;
					},
					Getter = (object o) => ((AimConstraint)o).worldUpVector,
					Updater = delegate(object o, ref object v)
					{
						Vector3 worldUpVector = ((AimConstraint)o).worldUpVector;
						if (!worldUpVector.Equals((Vector3)v))
						{
							v = worldUpVector;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "worldUpObject",
					PropertyType = typeof(Transform),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).worldUpObject = (Transform)v;
					},
					Getter = (object o) => ((AimConstraint)o).worldUpObject
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "locked",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).locked = (bool)v;
					},
					Getter = (object o) => ((AimConstraint)o).locked,
					Updater = delegate(object o, ref object v)
					{
						bool locked = ((AimConstraint)o).locked;
						if (!locked.Equals((bool)v))
						{
							v = locked;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationAtRest",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).rotationAtRest = (Vector3)v;
					},
					Getter = (object o) => ((AimConstraint)o).rotationAtRest,
					Updater = delegate(object o, ref object v)
					{
						Vector3 rotationAtRest = ((AimConstraint)o).rotationAtRest;
						if (!rotationAtRest.Equals((Vector3)v))
						{
							v = rotationAtRest;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationOffset",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).rotationOffset = (Vector3)v;
					},
					Getter = (object o) => ((AimConstraint)o).rotationOffset,
					Updater = delegate(object o, ref object v)
					{
						Vector3 rotationOffset = ((AimConstraint)o).rotationOffset;
						if (!rotationOffset.Equals((Vector3)v))
						{
							v = rotationOffset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationAxis",
					PropertyType = typeof(Axis),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).rotationAxis = (Axis)v;
					},
					Getter = (object o) => ((AimConstraint)o).rotationAxis,
					Updater = delegate(object o, ref object v)
					{
						int rotationAxis = (int)((AimConstraint)o).rotationAxis;
						if (!rotationAxis.Equals((int)v))
						{
							v = rotationAxis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AimConstraint)o).enabled = (bool)v;
					},
					Getter = (object o) => ((AimConstraint)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((AimConstraint)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Animation",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "clip",
					PropertyType = typeof(AnimationClip),
					Setter = (object o, object v) =>
					{
						((Animation)o).clip = (AnimationClip)v;
					},
					Getter = (object o) => ((Animation)o).clip
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "playAutomatically",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Animation)o).playAutomatically = (bool)v;
					},
					Getter = (object o) => ((Animation)o).playAutomatically,
					Updater = delegate(object o, ref object v)
					{
						bool playAutomatically = ((Animation)o).playAutomatically;
						if (!playAutomatically.Equals((bool)v))
						{
							v = playAutomatically;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "animatePhysics",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Animation)o).animatePhysics = (bool)v;
					},
					Getter = (object o) => ((Animation)o).animatePhysics,
					Updater = delegate(object o, ref object v)
					{
						bool animatePhysics = ((Animation)o).animatePhysics;
						if (!animatePhysics.Equals((bool)v))
						{
							v = animatePhysics;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cullingType",
					PropertyType = typeof(AnimationCullingType),
					Setter = (object o, object v) =>
					{
						((Animation)o).cullingType = (AnimationCullingType)v;
					},
					Getter = (object o) => ((Animation)o).cullingType,
					Updater = delegate(object o, ref object v)
					{
						int cullingType = (int)((Animation)o).cullingType;
						if (!cullingType.Equals((int)v))
						{
							v = cullingType;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Animation)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Animation)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Animation)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Animator",
			new ProximaComponentCommands.PropertyInfo[6]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "runtimeAnimatorController",
					PropertyType = typeof(RuntimeAnimatorController),
					Setter = (object o, object v) =>
					{
						((Animator)o).runtimeAnimatorController = (RuntimeAnimatorController)v;
					},
					Getter = (object o) => ((Animator)o).runtimeAnimatorController
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "avatar",
					PropertyType = typeof(Avatar),
					Setter = (object o, object v) =>
					{
						((Animator)o).avatar = (Avatar)v;
					},
					Getter = (object o) => ((Animator)o).avatar
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "applyRootMotion",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Animator)o).applyRootMotion = (bool)v;
					},
					Getter = (object o) => ((Animator)o).applyRootMotion,
					Updater = delegate(object o, ref object v)
					{
						bool applyRootMotion = ((Animator)o).applyRootMotion;
						if (!applyRootMotion.Equals((bool)v))
						{
							v = applyRootMotion;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "updateMode",
					PropertyType = typeof(AnimatorUpdateMode),
					Setter = (object o, object v) =>
					{
						((Animator)o).updateMode = (AnimatorUpdateMode)v;
					},
					Getter = (object o) => ((Animator)o).updateMode,
					Updater = delegate(object o, ref object v)
					{
						int updateMode = (int)((Animator)o).updateMode;
						if (!updateMode.Equals((int)v))
						{
							v = updateMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cullingMode",
					PropertyType = typeof(AnimatorCullingMode),
					Setter = (object o, object v) =>
					{
						((Animator)o).cullingMode = (AnimatorCullingMode)v;
					},
					Getter = (object o) => ((Animator)o).cullingMode,
					Updater = delegate(object o, ref object v)
					{
						int cullingMode = (int)((Animator)o).cullingMode;
						if (!cullingMode.Equals((int)v))
						{
							v = cullingMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Animator)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Animator)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Animator)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AreaEffector2D",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useColliderMask",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AreaEffector2D)o).useColliderMask = (bool)v;
					},
					Getter = (object o) => ((AreaEffector2D)o).useColliderMask,
					Updater = delegate(object o, ref object v)
					{
						bool useColliderMask = ((AreaEffector2D)o).useColliderMask;
						if (!useColliderMask.Equals((bool)v))
						{
							v = useColliderMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colliderMask",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((AreaEffector2D)o).colliderMask = (int)v;
					},
					Getter = (object o) => ((AreaEffector2D)o).colliderMask,
					Updater = delegate(object o, ref object v)
					{
						int colliderMask = ((AreaEffector2D)o).colliderMask;
						if (!colliderMask.Equals((int)v))
						{
							v = colliderMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useGlobalAngle",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AreaEffector2D)o).useGlobalAngle = (bool)v;
					},
					Getter = (object o) => ((AreaEffector2D)o).useGlobalAngle,
					Updater = delegate(object o, ref object v)
					{
						bool useGlobalAngle = ((AreaEffector2D)o).useGlobalAngle;
						if (!useGlobalAngle.Equals((bool)v))
						{
							v = useGlobalAngle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "forceAngle",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AreaEffector2D)o).forceAngle = (float)v;
					},
					Getter = (object o) => ((AreaEffector2D)o).forceAngle,
					Updater = delegate(object o, ref object v)
					{
						float forceAngle = ((AreaEffector2D)o).forceAngle;
						if (!forceAngle.Equals((float)v))
						{
							v = forceAngle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "forceMagnitude",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AreaEffector2D)o).forceMagnitude = (float)v;
					},
					Getter = (object o) => ((AreaEffector2D)o).forceMagnitude,
					Updater = delegate(object o, ref object v)
					{
						float forceMagnitude = ((AreaEffector2D)o).forceMagnitude;
						if (!forceMagnitude.Equals((float)v))
						{
							v = forceMagnitude;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "forceVariation",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AreaEffector2D)o).forceVariation = (float)v;
					},
					Getter = (object o) => ((AreaEffector2D)o).forceVariation,
					Updater = delegate(object o, ref object v)
					{
						float forceVariation = ((AreaEffector2D)o).forceVariation;
						if (!forceVariation.Equals((float)v))
						{
							v = forceVariation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "forceTarget",
					PropertyType = typeof(EffectorSelection2D),
					Setter = (object o, object v) =>
					{
						((AreaEffector2D)o).forceTarget = (EffectorSelection2D)v;
					},
					Getter = (object o) => ((AreaEffector2D)o).forceTarget,
					Updater = delegate(object o, ref object v)
					{
						int forceTarget = (int)((AreaEffector2D)o).forceTarget;
						if (!forceTarget.Equals((int)v))
						{
							v = forceTarget;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "drag",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AreaEffector2D)o).drag = (float)v;
					},
					Getter = (object o) => ((AreaEffector2D)o).drag,
					Updater = delegate(object o, ref object v)
					{
						float drag = ((AreaEffector2D)o).drag;
						if (!drag.Equals((float)v))
						{
							v = drag;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularDrag",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AreaEffector2D)o).angularDrag = (float)v;
					},
					Getter = (object o) => ((AreaEffector2D)o).angularDrag,
					Updater = delegate(object o, ref object v)
					{
						float angularDrag = ((AreaEffector2D)o).angularDrag;
						if (!angularDrag.Equals((float)v))
						{
							v = angularDrag;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AreaEffector2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((AreaEffector2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((AreaEffector2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.ArticulationBody",
			new ProximaComponentCommands.PropertyInfo[7]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "mass",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ArticulationBody)o).mass = (float)v;
					},
					Getter = (object o) => ((ArticulationBody)o).mass,
					Updater = delegate(object o, ref object v)
					{
						float mass = ((ArticulationBody)o).mass;
						if (!mass.Equals((float)v))
						{
							v = mass;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useGravity",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ArticulationBody)o).useGravity = (bool)v;
					},
					Getter = (object o) => ((ArticulationBody)o).useGravity,
					Updater = delegate(object o, ref object v)
					{
						bool useGravity = ((ArticulationBody)o).useGravity;
						if (!useGravity.Equals((bool)v))
						{
							v = useGravity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "immovable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ArticulationBody)o).immovable = (bool)v;
					},
					Getter = (object o) => ((ArticulationBody)o).immovable,
					Updater = delegate(object o, ref object v)
					{
						bool immovable = ((ArticulationBody)o).immovable;
						if (!immovable.Equals((bool)v))
						{
							v = immovable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "linearDamping",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ArticulationBody)o).linearDamping = (float)v;
					},
					Getter = (object o) => ((ArticulationBody)o).linearDamping,
					Updater = delegate(object o, ref object v)
					{
						float linearDamping = ((ArticulationBody)o).linearDamping;
						if (!linearDamping.Equals((float)v))
						{
							v = linearDamping;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularDamping",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ArticulationBody)o).angularDamping = (float)v;
					},
					Getter = (object o) => ((ArticulationBody)o).angularDamping,
					Updater = delegate(object o, ref object v)
					{
						float angularDamping = ((ArticulationBody)o).angularDamping;
						if (!angularDamping.Equals((float)v))
						{
							v = angularDamping;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "collisionDetectionMode",
					PropertyType = typeof(CollisionDetectionMode),
					Setter = (object o, object v) =>
					{
						((ArticulationBody)o).collisionDetectionMode = (CollisionDetectionMode)v;
					},
					Getter = (object o) => ((ArticulationBody)o).collisionDetectionMode,
					Updater = delegate(object o, ref object v)
					{
						int collisionDetectionMode = (int)((ArticulationBody)o).collisionDetectionMode;
						if (!collisionDetectionMode.Equals((int)v))
						{
							v = collisionDetectionMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ArticulationBody)o).enabled = (bool)v;
					},
					Getter = (object o) => ((ArticulationBody)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((ArticulationBody)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AudioChorusFilter",
			new ProximaComponentCommands.PropertyInfo[8]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "dryMix",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioChorusFilter)o).dryMix = (float)v;
					},
					Getter = (object o) => ((AudioChorusFilter)o).dryMix,
					Updater = delegate(object o, ref object v)
					{
						float dryMix = ((AudioChorusFilter)o).dryMix;
						if (!dryMix.Equals((float)v))
						{
							v = dryMix;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "wetMix1",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioChorusFilter)o).wetMix1 = (float)v;
					},
					Getter = (object o) => ((AudioChorusFilter)o).wetMix1,
					Updater = delegate(object o, ref object v)
					{
						float wetMix = ((AudioChorusFilter)o).wetMix1;
						if (!wetMix.Equals((float)v))
						{
							v = wetMix;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "wetMix2",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioChorusFilter)o).wetMix2 = (float)v;
					},
					Getter = (object o) => ((AudioChorusFilter)o).wetMix2,
					Updater = delegate(object o, ref object v)
					{
						float wetMix = ((AudioChorusFilter)o).wetMix2;
						if (!wetMix.Equals((float)v))
						{
							v = wetMix;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "wetMix3",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioChorusFilter)o).wetMix3 = (float)v;
					},
					Getter = (object o) => ((AudioChorusFilter)o).wetMix3,
					Updater = delegate(object o, ref object v)
					{
						float wetMix = ((AudioChorusFilter)o).wetMix3;
						if (!wetMix.Equals((float)v))
						{
							v = wetMix;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "delay",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioChorusFilter)o).delay = (float)v;
					},
					Getter = (object o) => ((AudioChorusFilter)o).delay,
					Updater = delegate(object o, ref object v)
					{
						float delay = ((AudioChorusFilter)o).delay;
						if (!delay.Equals((float)v))
						{
							v = delay;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rate",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioChorusFilter)o).rate = (float)v;
					},
					Getter = (object o) => ((AudioChorusFilter)o).rate,
					Updater = delegate(object o, ref object v)
					{
						float rate = ((AudioChorusFilter)o).rate;
						if (!rate.Equals((float)v))
						{
							v = rate;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "depth",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioChorusFilter)o).depth = (float)v;
					},
					Getter = (object o) => ((AudioChorusFilter)o).depth,
					Updater = delegate(object o, ref object v)
					{
						float depth = ((AudioChorusFilter)o).depth;
						if (!depth.Equals((float)v))
						{
							v = depth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioChorusFilter)o).enabled = (bool)v;
					},
					Getter = (object o) => ((AudioChorusFilter)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((AudioChorusFilter)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AudioDistortionFilter",
			new ProximaComponentCommands.PropertyInfo[2]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "distortionLevel",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioDistortionFilter)o).distortionLevel = (float)v;
					},
					Getter = (object o) => ((AudioDistortionFilter)o).distortionLevel,
					Updater = delegate(object o, ref object v)
					{
						float distortionLevel = ((AudioDistortionFilter)o).distortionLevel;
						if (!distortionLevel.Equals((float)v))
						{
							v = distortionLevel;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioDistortionFilter)o).enabled = (bool)v;
					},
					Getter = (object o) => ((AudioDistortionFilter)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((AudioDistortionFilter)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AudioEchoFilter",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "delay",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioEchoFilter)o).delay = (float)v;
					},
					Getter = (object o) => ((AudioEchoFilter)o).delay,
					Updater = delegate(object o, ref object v)
					{
						float delay = ((AudioEchoFilter)o).delay;
						if (!delay.Equals((float)v))
						{
							v = delay;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "decayRatio",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioEchoFilter)o).decayRatio = (float)v;
					},
					Getter = (object o) => ((AudioEchoFilter)o).decayRatio,
					Updater = delegate(object o, ref object v)
					{
						float decayRatio = ((AudioEchoFilter)o).decayRatio;
						if (!decayRatio.Equals((float)v))
						{
							v = decayRatio;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "dryMix",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioEchoFilter)o).dryMix = (float)v;
					},
					Getter = (object o) => ((AudioEchoFilter)o).dryMix,
					Updater = delegate(object o, ref object v)
					{
						float dryMix = ((AudioEchoFilter)o).dryMix;
						if (!dryMix.Equals((float)v))
						{
							v = dryMix;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "wetMix",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioEchoFilter)o).wetMix = (float)v;
					},
					Getter = (object o) => ((AudioEchoFilter)o).wetMix,
					Updater = delegate(object o, ref object v)
					{
						float wetMix = ((AudioEchoFilter)o).wetMix;
						if (!wetMix.Equals((float)v))
						{
							v = wetMix;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioEchoFilter)o).enabled = (bool)v;
					},
					Getter = (object o) => ((AudioEchoFilter)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((AudioEchoFilter)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AudioHighPassFilter",
			new ProximaComponentCommands.PropertyInfo[3]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cutoffFrequency",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioHighPassFilter)o).cutoffFrequency = (float)v;
					},
					Getter = (object o) => ((AudioHighPassFilter)o).cutoffFrequency,
					Updater = delegate(object o, ref object v)
					{
						float cutoffFrequency = ((AudioHighPassFilter)o).cutoffFrequency;
						if (!cutoffFrequency.Equals((float)v))
						{
							v = cutoffFrequency;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "highpassResonanceQ",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioHighPassFilter)o).highpassResonanceQ = (float)v;
					},
					Getter = (object o) => ((AudioHighPassFilter)o).highpassResonanceQ,
					Updater = delegate(object o, ref object v)
					{
						float highpassResonanceQ = ((AudioHighPassFilter)o).highpassResonanceQ;
						if (!highpassResonanceQ.Equals((float)v))
						{
							v = highpassResonanceQ;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioHighPassFilter)o).enabled = (bool)v;
					},
					Getter = (object o) => ((AudioHighPassFilter)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((AudioHighPassFilter)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AudioLowPassFilter",
			new ProximaComponentCommands.PropertyInfo[3]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cutoffFrequency",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioLowPassFilter)o).cutoffFrequency = (float)v;
					},
					Getter = (object o) => ((AudioLowPassFilter)o).cutoffFrequency,
					Updater = delegate(object o, ref object v)
					{
						float cutoffFrequency = ((AudioLowPassFilter)o).cutoffFrequency;
						if (!cutoffFrequency.Equals((float)v))
						{
							v = cutoffFrequency;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lowpassResonanceQ",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioLowPassFilter)o).lowpassResonanceQ = (float)v;
					},
					Getter = (object o) => ((AudioLowPassFilter)o).lowpassResonanceQ,
					Updater = delegate(object o, ref object v)
					{
						float lowpassResonanceQ = ((AudioLowPassFilter)o).lowpassResonanceQ;
						if (!lowpassResonanceQ.Equals((float)v))
						{
							v = lowpassResonanceQ;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioLowPassFilter)o).enabled = (bool)v;
					},
					Getter = (object o) => ((AudioLowPassFilter)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((AudioLowPassFilter)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AudioReverbFilter",
			new ProximaComponentCommands.PropertyInfo[16]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reverbPreset",
					PropertyType = typeof(AudioReverbPreset),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).reverbPreset = (AudioReverbPreset)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).reverbPreset,
					Updater = delegate(object o, ref object v)
					{
						int reverbPreset = (int)((AudioReverbFilter)o).reverbPreset;
						if (!reverbPreset.Equals((int)v))
						{
							v = reverbPreset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "dryLevel",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).dryLevel = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).dryLevel,
					Updater = delegate(object o, ref object v)
					{
						float dryLevel = ((AudioReverbFilter)o).dryLevel;
						if (!dryLevel.Equals((float)v))
						{
							v = dryLevel;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "room",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).room = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).room,
					Updater = delegate(object o, ref object v)
					{
						float room = ((AudioReverbFilter)o).room;
						if (!room.Equals((float)v))
						{
							v = room;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "roomHF",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).roomHF = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).roomHF,
					Updater = delegate(object o, ref object v)
					{
						float roomHF = ((AudioReverbFilter)o).roomHF;
						if (!roomHF.Equals((float)v))
						{
							v = roomHF;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "roomLF",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).roomLF = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).roomLF,
					Updater = delegate(object o, ref object v)
					{
						float roomLF = ((AudioReverbFilter)o).roomLF;
						if (!roomLF.Equals((float)v))
						{
							v = roomLF;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "decayTime",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).decayTime = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).decayTime,
					Updater = delegate(object o, ref object v)
					{
						float decayTime = ((AudioReverbFilter)o).decayTime;
						if (!decayTime.Equals((float)v))
						{
							v = decayTime;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "decayHFRatio",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).decayHFRatio = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).decayHFRatio,
					Updater = delegate(object o, ref object v)
					{
						float decayHFRatio = ((AudioReverbFilter)o).decayHFRatio;
						if (!decayHFRatio.Equals((float)v))
						{
							v = decayHFRatio;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reflectionsLevel",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).reflectionsLevel = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).reflectionsLevel,
					Updater = delegate(object o, ref object v)
					{
						float reflectionsLevel = ((AudioReverbFilter)o).reflectionsLevel;
						if (!reflectionsLevel.Equals((float)v))
						{
							v = reflectionsLevel;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reflectionsDelay",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).reflectionsDelay = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).reflectionsDelay,
					Updater = delegate(object o, ref object v)
					{
						float reflectionsDelay = ((AudioReverbFilter)o).reflectionsDelay;
						if (!reflectionsDelay.Equals((float)v))
						{
							v = reflectionsDelay;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reverbLevel",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).reverbLevel = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).reverbLevel,
					Updater = delegate(object o, ref object v)
					{
						float reverbLevel = ((AudioReverbFilter)o).reverbLevel;
						if (!reverbLevel.Equals((float)v))
						{
							v = reverbLevel;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reverbDelay",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).reverbDelay = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).reverbDelay,
					Updater = delegate(object o, ref object v)
					{
						float reverbDelay = ((AudioReverbFilter)o).reverbDelay;
						if (!reverbDelay.Equals((float)v))
						{
							v = reverbDelay;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "hfReference",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).hfReference = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).hfReference,
					Updater = delegate(object o, ref object v)
					{
						float hfReference = ((AudioReverbFilter)o).hfReference;
						if (!hfReference.Equals((float)v))
						{
							v = hfReference;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lfReference",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).lfReference = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).lfReference,
					Updater = delegate(object o, ref object v)
					{
						float lfReference = ((AudioReverbFilter)o).lfReference;
						if (!lfReference.Equals((float)v))
						{
							v = lfReference;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "diffusion",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).diffusion = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).diffusion,
					Updater = delegate(object o, ref object v)
					{
						float diffusion = ((AudioReverbFilter)o).diffusion;
						if (!diffusion.Equals((float)v))
						{
							v = diffusion;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "density",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).density = (float)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).density,
					Updater = delegate(object o, ref object v)
					{
						float density = ((AudioReverbFilter)o).density;
						if (!density.Equals((float)v))
						{
							v = density;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioReverbFilter)o).enabled = (bool)v;
					},
					Getter = (object o) => ((AudioReverbFilter)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((AudioReverbFilter)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AudioReverbZone",
			new ProximaComponentCommands.PropertyInfo[17]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "minDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).minDistance = (float)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).minDistance,
					Updater = delegate(object o, ref object v)
					{
						float minDistance = ((AudioReverbZone)o).minDistance;
						if (!minDistance.Equals((float)v))
						{
							v = minDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).maxDistance = (float)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).maxDistance,
					Updater = delegate(object o, ref object v)
					{
						float maxDistance = ((AudioReverbZone)o).maxDistance;
						if (!maxDistance.Equals((float)v))
						{
							v = maxDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reverbPreset",
					PropertyType = typeof(AudioReverbPreset),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).reverbPreset = (AudioReverbPreset)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).reverbPreset,
					Updater = delegate(object o, ref object v)
					{
						int reverbPreset = (int)((AudioReverbZone)o).reverbPreset;
						if (!reverbPreset.Equals((int)v))
						{
							v = reverbPreset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "room",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).room = (int)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).room,
					Updater = delegate(object o, ref object v)
					{
						int room = ((AudioReverbZone)o).room;
						if (!room.Equals((int)v))
						{
							v = room;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "roomHF",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).roomHF = (int)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).roomHF,
					Updater = delegate(object o, ref object v)
					{
						int roomHF = ((AudioReverbZone)o).roomHF;
						if (!roomHF.Equals((int)v))
						{
							v = roomHF;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "roomLF",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).roomLF = (int)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).roomLF,
					Updater = delegate(object o, ref object v)
					{
						int roomLF = ((AudioReverbZone)o).roomLF;
						if (!roomLF.Equals((int)v))
						{
							v = roomLF;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "decayTime",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).decayTime = (float)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).decayTime,
					Updater = delegate(object o, ref object v)
					{
						float decayTime = ((AudioReverbZone)o).decayTime;
						if (!decayTime.Equals((float)v))
						{
							v = decayTime;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "decayHFRatio",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).decayHFRatio = (float)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).decayHFRatio,
					Updater = delegate(object o, ref object v)
					{
						float decayHFRatio = ((AudioReverbZone)o).decayHFRatio;
						if (!decayHFRatio.Equals((float)v))
						{
							v = decayHFRatio;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reflections",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).reflections = (int)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).reflections,
					Updater = delegate(object o, ref object v)
					{
						int reflections = ((AudioReverbZone)o).reflections;
						if (!reflections.Equals((int)v))
						{
							v = reflections;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reflectionsDelay",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).reflectionsDelay = (float)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).reflectionsDelay,
					Updater = delegate(object o, ref object v)
					{
						float reflectionsDelay = ((AudioReverbZone)o).reflectionsDelay;
						if (!reflectionsDelay.Equals((float)v))
						{
							v = reflectionsDelay;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reverb",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).reverb = (int)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).reverb,
					Updater = delegate(object o, ref object v)
					{
						int reverb = ((AudioReverbZone)o).reverb;
						if (!reverb.Equals((int)v))
						{
							v = reverb;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reverbDelay",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).reverbDelay = (float)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).reverbDelay,
					Updater = delegate(object o, ref object v)
					{
						float reverbDelay = ((AudioReverbZone)o).reverbDelay;
						if (!reverbDelay.Equals((float)v))
						{
							v = reverbDelay;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "HFReference",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).HFReference = (float)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).HFReference,
					Updater = delegate(object o, ref object v)
					{
						float hFReference = ((AudioReverbZone)o).HFReference;
						if (!hFReference.Equals((float)v))
						{
							v = hFReference;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "LFReference",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).LFReference = (float)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).LFReference,
					Updater = delegate(object o, ref object v)
					{
						float lFReference = ((AudioReverbZone)o).LFReference;
						if (!lFReference.Equals((float)v))
						{
							v = lFReference;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "diffusion",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).diffusion = (float)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).diffusion,
					Updater = delegate(object o, ref object v)
					{
						float diffusion = ((AudioReverbZone)o).diffusion;
						if (!diffusion.Equals((float)v))
						{
							v = diffusion;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "density",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).density = (float)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).density,
					Updater = delegate(object o, ref object v)
					{
						float density = ((AudioReverbZone)o).density;
						if (!density.Equals((float)v))
						{
							v = density;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioReverbZone)o).enabled = (bool)v;
					},
					Getter = (object o) => ((AudioReverbZone)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((AudioReverbZone)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AudioSource",
			new ProximaComponentCommands.PropertyInfo[20]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "clip",
					PropertyType = typeof(AudioClip),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).clip = (AudioClip)v;
					},
					Getter = (object o) => ((AudioSource)o).clip
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "outputAudioMixerGroup",
					PropertyType = typeof(AudioMixerGroup),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).outputAudioMixerGroup = (AudioMixerGroup)v;
					},
					Getter = (object o) => ((AudioSource)o).outputAudioMixerGroup
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "mute",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).mute = (bool)v;
					},
					Getter = (object o) => ((AudioSource)o).mute,
					Updater = delegate(object o, ref object v)
					{
						bool mute = ((AudioSource)o).mute;
						if (!mute.Equals((bool)v))
						{
							v = mute;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "bypassEffects",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).bypassEffects = (bool)v;
					},
					Getter = (object o) => ((AudioSource)o).bypassEffects,
					Updater = delegate(object o, ref object v)
					{
						bool bypassEffects = ((AudioSource)o).bypassEffects;
						if (!bypassEffects.Equals((bool)v))
						{
							v = bypassEffects;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "bypassListenerEffects",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).bypassListenerEffects = (bool)v;
					},
					Getter = (object o) => ((AudioSource)o).bypassListenerEffects,
					Updater = delegate(object o, ref object v)
					{
						bool bypassListenerEffects = ((AudioSource)o).bypassListenerEffects;
						if (!bypassListenerEffects.Equals((bool)v))
						{
							v = bypassListenerEffects;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "bypassReverbZones",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).bypassReverbZones = (bool)v;
					},
					Getter = (object o) => ((AudioSource)o).bypassReverbZones,
					Updater = delegate(object o, ref object v)
					{
						bool bypassReverbZones = ((AudioSource)o).bypassReverbZones;
						if (!bypassReverbZones.Equals((bool)v))
						{
							v = bypassReverbZones;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "playOnAwake",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).playOnAwake = (bool)v;
					},
					Getter = (object o) => ((AudioSource)o).playOnAwake,
					Updater = delegate(object o, ref object v)
					{
						bool playOnAwake = ((AudioSource)o).playOnAwake;
						if (!playOnAwake.Equals((bool)v))
						{
							v = playOnAwake;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "loop",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).loop = (bool)v;
					},
					Getter = (object o) => ((AudioSource)o).loop,
					Updater = delegate(object o, ref object v)
					{
						bool loop = ((AudioSource)o).loop;
						if (!loop.Equals((bool)v))
						{
							v = loop;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "priority",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).priority = (int)v;
					},
					Getter = (object o) => ((AudioSource)o).priority,
					Updater = delegate(object o, ref object v)
					{
						int priority = ((AudioSource)o).priority;
						if (!priority.Equals((int)v))
						{
							v = priority;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "volume",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).volume = (float)v;
					},
					Getter = (object o) => ((AudioSource)o).volume,
					Updater = delegate(object o, ref object v)
					{
						float volume = ((AudioSource)o).volume;
						if (!volume.Equals((float)v))
						{
							v = volume;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "pitch",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).pitch = (float)v;
					},
					Getter = (object o) => ((AudioSource)o).pitch,
					Updater = delegate(object o, ref object v)
					{
						float pitch = ((AudioSource)o).pitch;
						if (!pitch.Equals((float)v))
						{
							v = pitch;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "panStereo",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).panStereo = (float)v;
					},
					Getter = (object o) => ((AudioSource)o).panStereo,
					Updater = delegate(object o, ref object v)
					{
						float panStereo = ((AudioSource)o).panStereo;
						if (!panStereo.Equals((float)v))
						{
							v = panStereo;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spatialBlend",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).spatialBlend = (float)v;
					},
					Getter = (object o) => ((AudioSource)o).spatialBlend,
					Updater = delegate(object o, ref object v)
					{
						float spatialBlend = ((AudioSource)o).spatialBlend;
						if (!spatialBlend.Equals((float)v))
						{
							v = spatialBlend;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reverbZoneMix",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).reverbZoneMix = (float)v;
					},
					Getter = (object o) => ((AudioSource)o).reverbZoneMix,
					Updater = delegate(object o, ref object v)
					{
						float reverbZoneMix = ((AudioSource)o).reverbZoneMix;
						if (!reverbZoneMix.Equals((float)v))
						{
							v = reverbZoneMix;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "dopplerLevel",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).dopplerLevel = (float)v;
					},
					Getter = (object o) => ((AudioSource)o).dopplerLevel,
					Updater = delegate(object o, ref object v)
					{
						float dopplerLevel = ((AudioSource)o).dopplerLevel;
						if (!dopplerLevel.Equals((float)v))
						{
							v = dopplerLevel;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spread",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).spread = (float)v;
					},
					Getter = (object o) => ((AudioSource)o).spread,
					Updater = delegate(object o, ref object v)
					{
						float spread = ((AudioSource)o).spread;
						if (!spread.Equals((float)v))
						{
							v = spread;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rolloffMode",
					PropertyType = typeof(AudioRolloffMode),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).rolloffMode = (AudioRolloffMode)v;
					},
					Getter = (object o) => ((AudioSource)o).rolloffMode,
					Updater = delegate(object o, ref object v)
					{
						int rolloffMode = (int)((AudioSource)o).rolloffMode;
						if (!rolloffMode.Equals((int)v))
						{
							v = rolloffMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "minDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).minDistance = (float)v;
					},
					Getter = (object o) => ((AudioSource)o).minDistance,
					Updater = delegate(object o, ref object v)
					{
						float minDistance = ((AudioSource)o).minDistance;
						if (!minDistance.Equals((float)v))
						{
							v = minDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).maxDistance = (float)v;
					},
					Getter = (object o) => ((AudioSource)o).maxDistance,
					Updater = delegate(object o, ref object v)
					{
						float maxDistance = ((AudioSource)o).maxDistance;
						if (!maxDistance.Equals((float)v))
						{
							v = maxDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((AudioSource)o).enabled = (bool)v;
					},
					Getter = (object o) => ((AudioSource)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((AudioSource)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.BoxCollider",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTrigger",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BoxCollider)o).isTrigger = (bool)v;
					},
					Getter = (object o) => ((BoxCollider)o).isTrigger,
					Updater = delegate(object o, ref object v)
					{
						bool isTrigger = ((BoxCollider)o).isTrigger;
						if (!isTrigger.Equals((bool)v))
						{
							v = isTrigger;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterial",
					PropertyType = typeof(PhysicMaterial),
					Setter = (object o, object v) =>
					{
						((BoxCollider)o).sharedMaterial = (PhysicMaterial)v;
					},
					Getter = (object o) => ((BoxCollider)o).sharedMaterial
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "center",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((BoxCollider)o).center = (Vector3)v;
					},
					Getter = (object o) => ((BoxCollider)o).center,
					Updater = delegate(object o, ref object v)
					{
						Vector3 center = ((BoxCollider)o).center;
						if (!center.Equals((Vector3)v))
						{
							v = center;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "size",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((BoxCollider)o).size = (Vector3)v;
					},
					Getter = (object o) => ((BoxCollider)o).size,
					Updater = delegate(object o, ref object v)
					{
						Vector3 size = ((BoxCollider)o).size;
						if (!size.Equals((Vector3)v))
						{
							v = size;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BoxCollider)o).enabled = (bool)v;
					},
					Getter = (object o) => ((BoxCollider)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((BoxCollider)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.BoxCollider2D",
			new ProximaComponentCommands.PropertyInfo[9]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterial",
					PropertyType = typeof(PhysicsMaterial2D),
					Setter = (object o, object v) =>
					{
						((BoxCollider2D)o).sharedMaterial = (PhysicsMaterial2D)v;
					},
					Getter = (object o) => ((BoxCollider2D)o).sharedMaterial
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTrigger",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BoxCollider2D)o).isTrigger = (bool)v;
					},
					Getter = (object o) => ((BoxCollider2D)o).isTrigger,
					Updater = delegate(object o, ref object v)
					{
						bool isTrigger = ((BoxCollider2D)o).isTrigger;
						if (!isTrigger.Equals((bool)v))
						{
							v = isTrigger;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByEffector",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BoxCollider2D)o).usedByEffector = (bool)v;
					},
					Getter = (object o) => ((BoxCollider2D)o).usedByEffector,
					Updater = delegate(object o, ref object v)
					{
						bool usedByEffector = ((BoxCollider2D)o).usedByEffector;
						if (!usedByEffector.Equals((bool)v))
						{
							v = usedByEffector;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByComposite",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BoxCollider2D)o).usedByComposite = (bool)v;
					},
					Getter = (object o) => ((BoxCollider2D)o).usedByComposite,
					Updater = delegate(object o, ref object v)
					{
						bool usedByComposite = ((BoxCollider2D)o).usedByComposite;
						if (!usedByComposite.Equals((bool)v))
						{
							v = usedByComposite;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "offset",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((BoxCollider2D)o).offset = (Vector2)v;
					},
					Getter = (object o) => ((BoxCollider2D)o).offset,
					Updater = delegate(object o, ref object v)
					{
						Vector2 offset = ((BoxCollider2D)o).offset;
						if (!offset.Equals((Vector2)v))
						{
							v = offset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoTiling",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BoxCollider2D)o).autoTiling = (bool)v;
					},
					Getter = (object o) => ((BoxCollider2D)o).autoTiling,
					Updater = delegate(object o, ref object v)
					{
						bool autoTiling = ((BoxCollider2D)o).autoTiling;
						if (!autoTiling.Equals((bool)v))
						{
							v = autoTiling;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "size",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((BoxCollider2D)o).size = (Vector2)v;
					},
					Getter = (object o) => ((BoxCollider2D)o).size,
					Updater = delegate(object o, ref object v)
					{
						Vector2 size = ((BoxCollider2D)o).size;
						if (!size.Equals((Vector2)v))
						{
							v = size;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "edgeRadius",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((BoxCollider2D)o).edgeRadius = (float)v;
					},
					Getter = (object o) => ((BoxCollider2D)o).edgeRadius,
					Updater = delegate(object o, ref object v)
					{
						float edgeRadius = ((BoxCollider2D)o).edgeRadius;
						if (!edgeRadius.Equals((float)v))
						{
							v = edgeRadius;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BoxCollider2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((BoxCollider2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((BoxCollider2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.BillboardRenderer",
			new ProximaComponentCommands.PropertyInfo[8]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "billboard",
					PropertyType = typeof(BillboardAsset),
					Setter = (object o, object v) =>
					{
						((BillboardRenderer)o).billboard = (BillboardAsset)v;
					},
					Getter = (object o) => ((BillboardRenderer)o).billboard
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shadowCastingMode",
					PropertyType = typeof(ShadowCastingMode),
					Setter = (object o, object v) =>
					{
						((BillboardRenderer)o).shadowCastingMode = (ShadowCastingMode)v;
					},
					Getter = (object o) => ((BillboardRenderer)o).shadowCastingMode,
					Updater = delegate(object o, ref object v)
					{
						int shadowCastingMode = (int)((BillboardRenderer)o).shadowCastingMode;
						if (!shadowCastingMode.Equals((int)v))
						{
							v = shadowCastingMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "receiveShadows",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BillboardRenderer)o).receiveShadows = (bool)v;
					},
					Getter = (object o) => ((BillboardRenderer)o).receiveShadows,
					Updater = delegate(object o, ref object v)
					{
						bool receiveShadows = ((BillboardRenderer)o).receiveShadows;
						if (!receiveShadows.Equals((bool)v))
						{
							v = receiveShadows;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lightProbeUsage",
					PropertyType = typeof(LightProbeUsage),
					Setter = (object o, object v) =>
					{
						((BillboardRenderer)o).lightProbeUsage = (LightProbeUsage)v;
					},
					Getter = (object o) => ((BillboardRenderer)o).lightProbeUsage,
					Updater = delegate(object o, ref object v)
					{
						int lightProbeUsage = (int)((BillboardRenderer)o).lightProbeUsage;
						if (!lightProbeUsage.Equals((int)v))
						{
							v = lightProbeUsage;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reflectionProbeUsage",
					PropertyType = typeof(ReflectionProbeUsage),
					Setter = (object o, object v) =>
					{
						((BillboardRenderer)o).reflectionProbeUsage = (ReflectionProbeUsage)v;
					},
					Getter = (object o) => ((BillboardRenderer)o).reflectionProbeUsage,
					Updater = delegate(object o, ref object v)
					{
						int reflectionProbeUsage = (int)((BillboardRenderer)o).reflectionProbeUsage;
						if (!reflectionProbeUsage.Equals((int)v))
						{
							v = reflectionProbeUsage;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "motionVectorGenerationMode",
					PropertyType = typeof(MotionVectorGenerationMode),
					Setter = (object o, object v) =>
					{
						((BillboardRenderer)o).motionVectorGenerationMode = (MotionVectorGenerationMode)v;
					},
					Getter = (object o) => ((BillboardRenderer)o).motionVectorGenerationMode,
					Updater = delegate(object o, ref object v)
					{
						int motionVectorGenerationMode = (int)((BillboardRenderer)o).motionVectorGenerationMode;
						if (!motionVectorGenerationMode.Equals((int)v))
						{
							v = motionVectorGenerationMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "allowOcclusionWhenDynamic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BillboardRenderer)o).allowOcclusionWhenDynamic = (bool)v;
					},
					Getter = (object o) => ((BillboardRenderer)o).allowOcclusionWhenDynamic,
					Updater = delegate(object o, ref object v)
					{
						bool allowOcclusionWhenDynamic = ((BillboardRenderer)o).allowOcclusionWhenDynamic;
						if (!allowOcclusionWhenDynamic.Equals((bool)v))
						{
							v = allowOcclusionWhenDynamic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BillboardRenderer)o).enabled = (bool)v;
					},
					Getter = (object o) => ((BillboardRenderer)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((BillboardRenderer)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.BuoyancyEffector2D",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useColliderMask",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BuoyancyEffector2D)o).useColliderMask = (bool)v;
					},
					Getter = (object o) => ((BuoyancyEffector2D)o).useColliderMask,
					Updater = delegate(object o, ref object v)
					{
						bool useColliderMask = ((BuoyancyEffector2D)o).useColliderMask;
						if (!useColliderMask.Equals((bool)v))
						{
							v = useColliderMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colliderMask",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((BuoyancyEffector2D)o).colliderMask = (int)v;
					},
					Getter = (object o) => ((BuoyancyEffector2D)o).colliderMask,
					Updater = delegate(object o, ref object v)
					{
						int colliderMask = ((BuoyancyEffector2D)o).colliderMask;
						if (!colliderMask.Equals((int)v))
						{
							v = colliderMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "density",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((BuoyancyEffector2D)o).density = (float)v;
					},
					Getter = (object o) => ((BuoyancyEffector2D)o).density,
					Updater = delegate(object o, ref object v)
					{
						float density = ((BuoyancyEffector2D)o).density;
						if (!density.Equals((float)v))
						{
							v = density;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "surfaceLevel",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((BuoyancyEffector2D)o).surfaceLevel = (float)v;
					},
					Getter = (object o) => ((BuoyancyEffector2D)o).surfaceLevel,
					Updater = delegate(object o, ref object v)
					{
						float surfaceLevel = ((BuoyancyEffector2D)o).surfaceLevel;
						if (!surfaceLevel.Equals((float)v))
						{
							v = surfaceLevel;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "linearDrag",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((BuoyancyEffector2D)o).linearDrag = (float)v;
					},
					Getter = (object o) => ((BuoyancyEffector2D)o).linearDrag,
					Updater = delegate(object o, ref object v)
					{
						float linearDrag = ((BuoyancyEffector2D)o).linearDrag;
						if (!linearDrag.Equals((float)v))
						{
							v = linearDrag;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularDrag",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((BuoyancyEffector2D)o).angularDrag = (float)v;
					},
					Getter = (object o) => ((BuoyancyEffector2D)o).angularDrag,
					Updater = delegate(object o, ref object v)
					{
						float angularDrag = ((BuoyancyEffector2D)o).angularDrag;
						if (!angularDrag.Equals((float)v))
						{
							v = angularDrag;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "flowAngle",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((BuoyancyEffector2D)o).flowAngle = (float)v;
					},
					Getter = (object o) => ((BuoyancyEffector2D)o).flowAngle,
					Updater = delegate(object o, ref object v)
					{
						float flowAngle = ((BuoyancyEffector2D)o).flowAngle;
						if (!flowAngle.Equals((float)v))
						{
							v = flowAngle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "flowMagnitude",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((BuoyancyEffector2D)o).flowMagnitude = (float)v;
					},
					Getter = (object o) => ((BuoyancyEffector2D)o).flowMagnitude,
					Updater = delegate(object o, ref object v)
					{
						float flowMagnitude = ((BuoyancyEffector2D)o).flowMagnitude;
						if (!flowMagnitude.Equals((float)v))
						{
							v = flowMagnitude;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "flowVariation",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((BuoyancyEffector2D)o).flowVariation = (float)v;
					},
					Getter = (object o) => ((BuoyancyEffector2D)o).flowVariation,
					Updater = delegate(object o, ref object v)
					{
						float flowVariation = ((BuoyancyEffector2D)o).flowVariation;
						if (!flowVariation.Equals((float)v))
						{
							v = flowVariation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((BuoyancyEffector2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((BuoyancyEffector2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((BuoyancyEffector2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.Button",
			new ProximaComponentCommands.PropertyInfo[6]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "interactable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Button)o).interactable = (bool)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Button)o).interactable,
					Updater = delegate(object o, ref object v)
					{
						bool interactable = ((UnityEngine.UI.Button)o).interactable;
						if (!interactable.Equals((bool)v))
						{
							v = interactable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "transition",
					PropertyType = typeof(Selectable.Transition),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Button)o).transition = (Selectable.Transition)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Button)o).transition,
					Updater = delegate(object o, ref object v)
					{
						int transition = (int)((UnityEngine.UI.Button)o).transition;
						if (!transition.Equals((int)v))
						{
							v = transition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetGraphic",
					PropertyType = typeof(Graphic),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Button)o).targetGraphic = (Graphic)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Button)o).targetGraphic
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colors",
					PropertyType = typeof(ColorBlock),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Button)o).colors = (ColorBlock)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Button)o).colors,
					Updater = delegate(object o, ref object v)
					{
						ColorBlock colors = ((UnityEngine.UI.Button)o).colors;
						if (!colors.Equals((ColorBlock)v))
						{
							v = colors;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "navigation",
					PropertyType = typeof(Navigation),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Button)o).navigation = (Navigation)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Button)o).navigation,
					Updater = delegate(object o, ref object v)
					{
						Navigation navigation = ((UnityEngine.UI.Button)o).navigation;
						if (!navigation.Equals((Navigation)v))
						{
							v = navigation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Button)o).enabled = (bool)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Button)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((UnityEngine.UI.Button)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Camera",
			new ProximaComponentCommands.PropertyInfo[18]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "clearFlags",
					PropertyType = typeof(CameraClearFlags),
					Setter = (object o, object v) =>
					{
						((Camera)o).clearFlags = (CameraClearFlags)v;
					},
					Getter = (object o) => ((Camera)o).clearFlags,
					Updater = delegate(object o, ref object v)
					{
						int clearFlags = (int)((Camera)o).clearFlags;
						if (!clearFlags.Equals((int)v))
						{
							v = clearFlags;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "backgroundColor",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((Camera)o).backgroundColor = (Color)v;
					},
					Getter = (object o) => ((Camera)o).backgroundColor,
					Updater = delegate(object o, ref object v)
					{
						Color backgroundColor = ((Camera)o).backgroundColor;
						if (!backgroundColor.Equals((Color)v))
						{
							v = backgroundColor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cullingMask",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((Camera)o).cullingMask = (int)v;
					},
					Getter = (object o) => ((Camera)o).cullingMask,
					Updater = delegate(object o, ref object v)
					{
						int cullingMask = ((Camera)o).cullingMask;
						if (!cullingMask.Equals((int)v))
						{
							v = cullingMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "orthographic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Camera)o).orthographic = (bool)v;
					},
					Getter = (object o) => ((Camera)o).orthographic,
					Updater = delegate(object o, ref object v)
					{
						bool orthographic = ((Camera)o).orthographic;
						if (!orthographic.Equals((bool)v))
						{
							v = orthographic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fieldOfView",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Camera)o).fieldOfView = (float)v;
					},
					Getter = (object o) => ((Camera)o).fieldOfView,
					Updater = delegate(object o, ref object v)
					{
						float fieldOfView = ((Camera)o).fieldOfView;
						if (!fieldOfView.Equals((float)v))
						{
							v = fieldOfView;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usePhysicalProperties",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Camera)o).usePhysicalProperties = (bool)v;
					},
					Getter = (object o) => ((Camera)o).usePhysicalProperties,
					Updater = delegate(object o, ref object v)
					{
						bool usePhysicalProperties = ((Camera)o).usePhysicalProperties;
						if (!usePhysicalProperties.Equals((bool)v))
						{
							v = usePhysicalProperties;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "nearClipPlane",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Camera)o).nearClipPlane = (float)v;
					},
					Getter = (object o) => ((Camera)o).nearClipPlane,
					Updater = delegate(object o, ref object v)
					{
						float nearClipPlane = ((Camera)o).nearClipPlane;
						if (!nearClipPlane.Equals((float)v))
						{
							v = nearClipPlane;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "farClipPlane",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Camera)o).farClipPlane = (float)v;
					},
					Getter = (object o) => ((Camera)o).farClipPlane,
					Updater = delegate(object o, ref object v)
					{
						float farClipPlane = ((Camera)o).farClipPlane;
						if (!farClipPlane.Equals((float)v))
						{
							v = farClipPlane;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rect",
					PropertyType = typeof(Rect),
					Setter = (object o, object v) =>
					{
						((Camera)o).rect = (Rect)v;
					},
					Getter = (object o) => ((Camera)o).rect,
					Updater = delegate(object o, ref object v)
					{
						Rect rect = ((Camera)o).rect;
						if (!rect.Equals((Rect)v))
						{
							v = rect;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "depth",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Camera)o).depth = (float)v;
					},
					Getter = (object o) => ((Camera)o).depth,
					Updater = delegate(object o, ref object v)
					{
						float depth = ((Camera)o).depth;
						if (!depth.Equals((float)v))
						{
							v = depth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "renderingPath",
					PropertyType = typeof(RenderingPath),
					Setter = (object o, object v) =>
					{
						((Camera)o).renderingPath = (RenderingPath)v;
					},
					Getter = (object o) => ((Camera)o).renderingPath,
					Updater = delegate(object o, ref object v)
					{
						int renderingPath = (int)((Camera)o).renderingPath;
						if (!renderingPath.Equals((int)v))
						{
							v = renderingPath;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetTexture",
					PropertyType = typeof(RenderTexture),
					Setter = (object o, object v) =>
					{
						((Camera)o).targetTexture = (RenderTexture)v;
					},
					Getter = (object o) => ((Camera)o).targetTexture
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useOcclusionCulling",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Camera)o).useOcclusionCulling = (bool)v;
					},
					Getter = (object o) => ((Camera)o).useOcclusionCulling,
					Updater = delegate(object o, ref object v)
					{
						bool useOcclusionCulling = ((Camera)o).useOcclusionCulling;
						if (!useOcclusionCulling.Equals((bool)v))
						{
							v = useOcclusionCulling;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "allowHDR",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Camera)o).allowHDR = (bool)v;
					},
					Getter = (object o) => ((Camera)o).allowHDR,
					Updater = delegate(object o, ref object v)
					{
						bool allowHDR = ((Camera)o).allowHDR;
						if (!allowHDR.Equals((bool)v))
						{
							v = allowHDR;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "allowMSAA",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Camera)o).allowMSAA = (bool)v;
					},
					Getter = (object o) => ((Camera)o).allowMSAA,
					Updater = delegate(object o, ref object v)
					{
						bool allowMSAA = ((Camera)o).allowMSAA;
						if (!allowMSAA.Equals((bool)v))
						{
							v = allowMSAA;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "allowDynamicResolution",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Camera)o).allowDynamicResolution = (bool)v;
					},
					Getter = (object o) => ((Camera)o).allowDynamicResolution,
					Updater = delegate(object o, ref object v)
					{
						bool allowDynamicResolution = ((Camera)o).allowDynamicResolution;
						if (!allowDynamicResolution.Equals((bool)v))
						{
							v = allowDynamicResolution;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetDisplay",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((Camera)o).targetDisplay = (int)v;
					},
					Getter = (object o) => ((Camera)o).targetDisplay,
					Updater = delegate(object o, ref object v)
					{
						int targetDisplay = ((Camera)o).targetDisplay;
						if (!targetDisplay.Equals((int)v))
						{
							v = targetDisplay;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Camera)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Camera)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Camera)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Canvas",
			new ProximaComponentCommands.PropertyInfo[7]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "renderMode",
					PropertyType = typeof(RenderMode),
					Setter = (object o, object v) =>
					{
						((Canvas)o).renderMode = (RenderMode)v;
					},
					Getter = (object o) => ((Canvas)o).renderMode,
					Updater = delegate(object o, ref object v)
					{
						int renderMode = (int)((Canvas)o).renderMode;
						if (!renderMode.Equals((int)v))
						{
							v = renderMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "worldCamera",
					PropertyType = typeof(Camera),
					Setter = (object o, object v) =>
					{
						((Canvas)o).worldCamera = (Camera)v;
					},
					Getter = (object o) => ((Canvas)o).worldCamera
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "pixelPerfect",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Canvas)o).pixelPerfect = (bool)v;
					},
					Getter = (object o) => ((Canvas)o).pixelPerfect,
					Updater = delegate(object o, ref object v)
					{
						bool pixelPerfect = ((Canvas)o).pixelPerfect;
						if (!pixelPerfect.Equals((bool)v))
						{
							v = pixelPerfect;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingOrder",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((Canvas)o).sortingOrder = (int)v;
					},
					Getter = (object o) => ((Canvas)o).sortingOrder,
					Updater = delegate(object o, ref object v)
					{
						int sortingOrder = ((Canvas)o).sortingOrder;
						if (!sortingOrder.Equals((int)v))
						{
							v = sortingOrder;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetDisplay",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((Canvas)o).targetDisplay = (int)v;
					},
					Getter = (object o) => ((Canvas)o).targetDisplay,
					Updater = delegate(object o, ref object v)
					{
						int targetDisplay = ((Canvas)o).targetDisplay;
						if (!targetDisplay.Equals((int)v))
						{
							v = targetDisplay;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "additionalShaderChannels",
					PropertyType = typeof(AdditionalCanvasShaderChannels),
					Setter = (object o, object v) =>
					{
						((Canvas)o).additionalShaderChannels = (AdditionalCanvasShaderChannels)v;
					},
					Getter = (object o) => ((Canvas)o).additionalShaderChannels,
					Updater = delegate(object o, ref object v)
					{
						int additionalShaderChannels = (int)((Canvas)o).additionalShaderChannels;
						if (!additionalShaderChannels.Equals((int)v))
						{
							v = additionalShaderChannels;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Canvas)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Canvas)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Canvas)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.CanvasGroup",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "alpha",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CanvasGroup)o).alpha = (float)v;
					},
					Getter = (object o) => ((CanvasGroup)o).alpha,
					Updater = delegate(object o, ref object v)
					{
						float alpha = ((CanvasGroup)o).alpha;
						if (!alpha.Equals((float)v))
						{
							v = alpha;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "interactable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CanvasGroup)o).interactable = (bool)v;
					},
					Getter = (object o) => ((CanvasGroup)o).interactable,
					Updater = delegate(object o, ref object v)
					{
						bool interactable = ((CanvasGroup)o).interactable;
						if (!interactable.Equals((bool)v))
						{
							v = interactable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "blocksRaycasts",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CanvasGroup)o).blocksRaycasts = (bool)v;
					},
					Getter = (object o) => ((CanvasGroup)o).blocksRaycasts,
					Updater = delegate(object o, ref object v)
					{
						bool blocksRaycasts = ((CanvasGroup)o).blocksRaycasts;
						if (!blocksRaycasts.Equals((bool)v))
						{
							v = blocksRaycasts;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "ignoreParentGroups",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CanvasGroup)o).ignoreParentGroups = (bool)v;
					},
					Getter = (object o) => ((CanvasGroup)o).ignoreParentGroups,
					Updater = delegate(object o, ref object v)
					{
						bool ignoreParentGroups = ((CanvasGroup)o).ignoreParentGroups;
						if (!ignoreParentGroups.Equals((bool)v))
						{
							v = ignoreParentGroups;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CanvasGroup)o).enabled = (bool)v;
					},
					Getter = (object o) => ((CanvasGroup)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((CanvasGroup)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.CanvasRenderer",
			new ProximaComponentCommands.PropertyInfo[1]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cullTransparentMesh",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CanvasRenderer)o).cullTransparentMesh = (bool)v;
					},
					Getter = (object o) => ((CanvasRenderer)o).cullTransparentMesh,
					Updater = delegate(object o, ref object v)
					{
						bool cullTransparentMesh = ((CanvasRenderer)o).cullTransparentMesh;
						if (!cullTransparentMesh.Equals((bool)v))
						{
							v = cullTransparentMesh;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.CanvasScaler",
			new ProximaComponentCommands.PropertyInfo[9]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "uiScaleMode",
					PropertyType = typeof(CanvasScaler.ScaleMode),
					Setter = (object o, object v) =>
					{
						((CanvasScaler)o).uiScaleMode = (CanvasScaler.ScaleMode)v;
					},
					Getter = (object o) => ((CanvasScaler)o).uiScaleMode,
					Updater = delegate(object o, ref object v)
					{
						int uiScaleMode = (int)((CanvasScaler)o).uiScaleMode;
						if (!uiScaleMode.Equals((int)v))
						{
							v = uiScaleMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "scaleFactor",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CanvasScaler)o).scaleFactor = (float)v;
					},
					Getter = (object o) => ((CanvasScaler)o).scaleFactor,
					Updater = delegate(object o, ref object v)
					{
						float scaleFactor = ((CanvasScaler)o).scaleFactor;
						if (!scaleFactor.Equals((float)v))
						{
							v = scaleFactor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "referenceResolution",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((CanvasScaler)o).referenceResolution = (Vector2)v;
					},
					Getter = (object o) => ((CanvasScaler)o).referenceResolution,
					Updater = delegate(object o, ref object v)
					{
						Vector2 referenceResolution = ((CanvasScaler)o).referenceResolution;
						if (!referenceResolution.Equals((Vector2)v))
						{
							v = referenceResolution;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "screenMatchMode",
					PropertyType = typeof(CanvasScaler.ScreenMatchMode),
					Setter = (object o, object v) =>
					{
						((CanvasScaler)o).screenMatchMode = (CanvasScaler.ScreenMatchMode)v;
					},
					Getter = (object o) => ((CanvasScaler)o).screenMatchMode,
					Updater = delegate(object o, ref object v)
					{
						int screenMatchMode = (int)((CanvasScaler)o).screenMatchMode;
						if (!screenMatchMode.Equals((int)v))
						{
							v = screenMatchMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "physicalUnit",
					PropertyType = typeof(CanvasScaler.Unit),
					Setter = (object o, object v) =>
					{
						((CanvasScaler)o).physicalUnit = (CanvasScaler.Unit)v;
					},
					Getter = (object o) => ((CanvasScaler)o).physicalUnit,
					Updater = delegate(object o, ref object v)
					{
						int physicalUnit = (int)((CanvasScaler)o).physicalUnit;
						if (!physicalUnit.Equals((int)v))
						{
							v = physicalUnit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fallbackScreenDPI",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CanvasScaler)o).fallbackScreenDPI = (float)v;
					},
					Getter = (object o) => ((CanvasScaler)o).fallbackScreenDPI,
					Updater = delegate(object o, ref object v)
					{
						float fallbackScreenDPI = ((CanvasScaler)o).fallbackScreenDPI;
						if (!fallbackScreenDPI.Equals((float)v))
						{
							v = fallbackScreenDPI;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "defaultSpriteDPI",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CanvasScaler)o).defaultSpriteDPI = (float)v;
					},
					Getter = (object o) => ((CanvasScaler)o).defaultSpriteDPI,
					Updater = delegate(object o, ref object v)
					{
						float defaultSpriteDPI = ((CanvasScaler)o).defaultSpriteDPI;
						if (!defaultSpriteDPI.Equals((float)v))
						{
							v = defaultSpriteDPI;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "referencePixelsPerUnit",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CanvasScaler)o).referencePixelsPerUnit = (float)v;
					},
					Getter = (object o) => ((CanvasScaler)o).referencePixelsPerUnit,
					Updater = delegate(object o, ref object v)
					{
						float referencePixelsPerUnit = ((CanvasScaler)o).referencePixelsPerUnit;
						if (!referencePixelsPerUnit.Equals((float)v))
						{
							v = referencePixelsPerUnit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CanvasScaler)o).enabled = (bool)v;
					},
					Getter = (object o) => ((CanvasScaler)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((CanvasScaler)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.CapsuleCollider",
			new ProximaComponentCommands.PropertyInfo[7]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTrigger",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider)o).isTrigger = (bool)v;
					},
					Getter = (object o) => ((CapsuleCollider)o).isTrigger,
					Updater = delegate(object o, ref object v)
					{
						bool isTrigger = ((CapsuleCollider)o).isTrigger;
						if (!isTrigger.Equals((bool)v))
						{
							v = isTrigger;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterial",
					PropertyType = typeof(PhysicMaterial),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider)o).sharedMaterial = (PhysicMaterial)v;
					},
					Getter = (object o) => ((CapsuleCollider)o).sharedMaterial
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "center",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider)o).center = (Vector3)v;
					},
					Getter = (object o) => ((CapsuleCollider)o).center,
					Updater = delegate(object o, ref object v)
					{
						Vector3 center = ((CapsuleCollider)o).center;
						if (!center.Equals((Vector3)v))
						{
							v = center;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "radius",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider)o).radius = (float)v;
					},
					Getter = (object o) => ((CapsuleCollider)o).radius,
					Updater = delegate(object o, ref object v)
					{
						float radius = ((CapsuleCollider)o).radius;
						if (!radius.Equals((float)v))
						{
							v = radius;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "height",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider)o).height = (float)v;
					},
					Getter = (object o) => ((CapsuleCollider)o).height,
					Updater = delegate(object o, ref object v)
					{
						float height = ((CapsuleCollider)o).height;
						if (!height.Equals((float)v))
						{
							v = height;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "direction",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider)o).direction = (int)v;
					},
					Getter = (object o) => ((CapsuleCollider)o).direction,
					Updater = delegate(object o, ref object v)
					{
						int direction = ((CapsuleCollider)o).direction;
						if (!direction.Equals((int)v))
						{
							v = direction;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider)o).enabled = (bool)v;
					},
					Getter = (object o) => ((CapsuleCollider)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((CapsuleCollider)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.CapsuleCollider2D",
			new ProximaComponentCommands.PropertyInfo[8]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterial",
					PropertyType = typeof(PhysicsMaterial2D),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider2D)o).sharedMaterial = (PhysicsMaterial2D)v;
					},
					Getter = (object o) => ((CapsuleCollider2D)o).sharedMaterial
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTrigger",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider2D)o).isTrigger = (bool)v;
					},
					Getter = (object o) => ((CapsuleCollider2D)o).isTrigger,
					Updater = delegate(object o, ref object v)
					{
						bool isTrigger = ((CapsuleCollider2D)o).isTrigger;
						if (!isTrigger.Equals((bool)v))
						{
							v = isTrigger;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByEffector",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider2D)o).usedByEffector = (bool)v;
					},
					Getter = (object o) => ((CapsuleCollider2D)o).usedByEffector,
					Updater = delegate(object o, ref object v)
					{
						bool usedByEffector = ((CapsuleCollider2D)o).usedByEffector;
						if (!usedByEffector.Equals((bool)v))
						{
							v = usedByEffector;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByComposite",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider2D)o).usedByComposite = (bool)v;
					},
					Getter = (object o) => ((CapsuleCollider2D)o).usedByComposite,
					Updater = delegate(object o, ref object v)
					{
						bool usedByComposite = ((CapsuleCollider2D)o).usedByComposite;
						if (!usedByComposite.Equals((bool)v))
						{
							v = usedByComposite;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "offset",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider2D)o).offset = (Vector2)v;
					},
					Getter = (object o) => ((CapsuleCollider2D)o).offset,
					Updater = delegate(object o, ref object v)
					{
						Vector2 offset = ((CapsuleCollider2D)o).offset;
						if (!offset.Equals((Vector2)v))
						{
							v = offset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "size",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider2D)o).size = (Vector2)v;
					},
					Getter = (object o) => ((CapsuleCollider2D)o).size,
					Updater = delegate(object o, ref object v)
					{
						Vector2 size = ((CapsuleCollider2D)o).size;
						if (!size.Equals((Vector2)v))
						{
							v = size;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "direction",
					PropertyType = typeof(CapsuleDirection2D),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider2D)o).direction = (CapsuleDirection2D)v;
					},
					Getter = (object o) => ((CapsuleCollider2D)o).direction,
					Updater = delegate(object o, ref object v)
					{
						int direction = (int)((CapsuleCollider2D)o).direction;
						if (!direction.Equals((int)v))
						{
							v = direction;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CapsuleCollider2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((CapsuleCollider2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((CapsuleCollider2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.CharacterController",
			new ProximaComponentCommands.PropertyInfo[8]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "slopeLimit",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterController)o).slopeLimit = (float)v;
					},
					Getter = (object o) => ((CharacterController)o).slopeLimit,
					Updater = delegate(object o, ref object v)
					{
						float slopeLimit = ((CharacterController)o).slopeLimit;
						if (!slopeLimit.Equals((float)v))
						{
							v = slopeLimit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "stepOffset",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterController)o).stepOffset = (float)v;
					},
					Getter = (object o) => ((CharacterController)o).stepOffset,
					Updater = delegate(object o, ref object v)
					{
						float stepOffset = ((CharacterController)o).stepOffset;
						if (!stepOffset.Equals((float)v))
						{
							v = stepOffset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "skinWidth",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterController)o).skinWidth = (float)v;
					},
					Getter = (object o) => ((CharacterController)o).skinWidth,
					Updater = delegate(object o, ref object v)
					{
						float skinWidth = ((CharacterController)o).skinWidth;
						if (!skinWidth.Equals((float)v))
						{
							v = skinWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "minMoveDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterController)o).minMoveDistance = (float)v;
					},
					Getter = (object o) => ((CharacterController)o).minMoveDistance,
					Updater = delegate(object o, ref object v)
					{
						float minMoveDistance = ((CharacterController)o).minMoveDistance;
						if (!minMoveDistance.Equals((float)v))
						{
							v = minMoveDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "center",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((CharacterController)o).center = (Vector3)v;
					},
					Getter = (object o) => ((CharacterController)o).center,
					Updater = delegate(object o, ref object v)
					{
						Vector3 center = ((CharacterController)o).center;
						if (!center.Equals((Vector3)v))
						{
							v = center;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "radius",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterController)o).radius = (float)v;
					},
					Getter = (object o) => ((CharacterController)o).radius,
					Updater = delegate(object o, ref object v)
					{
						float radius = ((CharacterController)o).radius;
						if (!radius.Equals((float)v))
						{
							v = radius;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "height",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterController)o).height = (float)v;
					},
					Getter = (object o) => ((CharacterController)o).height,
					Updater = delegate(object o, ref object v)
					{
						float height = ((CharacterController)o).height;
						if (!height.Equals((float)v))
						{
							v = height;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CharacterController)o).enabled = (bool)v;
					},
					Getter = (object o) => ((CharacterController)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((CharacterController)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.CharacterJoint",
			new ProximaComponentCommands.PropertyInfo[22]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).connectedBody = (Rigidbody)v;
					},
					Getter = (object o) => ((CharacterJoint)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedArticulationBody",
					PropertyType = typeof(ArticulationBody),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).connectedArticulationBody = (ArticulationBody)v;
					},
					Getter = (object o) => ((CharacterJoint)o).connectedArticulationBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).anchor = (Vector3)v;
					},
					Getter = (object o) => ((CharacterJoint)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector3 anchor = ((CharacterJoint)o).anchor;
						if (!anchor.Equals((Vector3)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "axis",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).axis = (Vector3)v;
					},
					Getter = (object o) => ((CharacterJoint)o).axis,
					Updater = delegate(object o, ref object v)
					{
						Vector3 axis = ((CharacterJoint)o).axis;
						if (!axis.Equals((Vector3)v))
						{
							v = axis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureConnectedAnchor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).autoConfigureConnectedAnchor = (bool)v;
					},
					Getter = (object o) => ((CharacterJoint)o).autoConfigureConnectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureConnectedAnchor = ((CharacterJoint)o).autoConfigureConnectedAnchor;
						if (!autoConfigureConnectedAnchor.Equals((bool)v))
						{
							v = autoConfigureConnectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedAnchor",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).connectedAnchor = (Vector3)v;
					},
					Getter = (object o) => ((CharacterJoint)o).connectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						Vector3 connectedAnchor = ((CharacterJoint)o).connectedAnchor;
						if (!connectedAnchor.Equals((Vector3)v))
						{
							v = connectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "swingAxis",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).swingAxis = (Vector3)v;
					},
					Getter = (object o) => ((CharacterJoint)o).swingAxis,
					Updater = delegate(object o, ref object v)
					{
						Vector3 swingAxis = ((CharacterJoint)o).swingAxis;
						if (!swingAxis.Equals((Vector3)v))
						{
							v = swingAxis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "twistLimitSpring",
					PropertyType = typeof(SoftJointLimitSpring),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).twistLimitSpring = (SoftJointLimitSpring)v;
					},
					Getter = (object o) => ((CharacterJoint)o).twistLimitSpring,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimitSpring twistLimitSpring = ((CharacterJoint)o).twistLimitSpring;
						if (!twistLimitSpring.Equals((SoftJointLimitSpring)v))
						{
							v = twistLimitSpring;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lowTwistLimit",
					PropertyType = typeof(SoftJointLimit),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).lowTwistLimit = (SoftJointLimit)v;
					},
					Getter = (object o) => ((CharacterJoint)o).lowTwistLimit,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimit lowTwistLimit = ((CharacterJoint)o).lowTwistLimit;
						if (!lowTwistLimit.Equals((SoftJointLimit)v))
						{
							v = lowTwistLimit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "highTwistLimit",
					PropertyType = typeof(SoftJointLimit),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).highTwistLimit = (SoftJointLimit)v;
					},
					Getter = (object o) => ((CharacterJoint)o).highTwistLimit,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimit highTwistLimit = ((CharacterJoint)o).highTwistLimit;
						if (!highTwistLimit.Equals((SoftJointLimit)v))
						{
							v = highTwistLimit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "swingLimitSpring",
					PropertyType = typeof(SoftJointLimitSpring),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).swingLimitSpring = (SoftJointLimitSpring)v;
					},
					Getter = (object o) => ((CharacterJoint)o).swingLimitSpring,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimitSpring swingLimitSpring = ((CharacterJoint)o).swingLimitSpring;
						if (!swingLimitSpring.Equals((SoftJointLimitSpring)v))
						{
							v = swingLimitSpring;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "swing1Limit",
					PropertyType = typeof(SoftJointLimit),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).swing1Limit = (SoftJointLimit)v;
					},
					Getter = (object o) => ((CharacterJoint)o).swing1Limit,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimit swing1Limit = ((CharacterJoint)o).swing1Limit;
						if (!swing1Limit.Equals((SoftJointLimit)v))
						{
							v = swing1Limit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "swing2Limit",
					PropertyType = typeof(SoftJointLimit),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).swing2Limit = (SoftJointLimit)v;
					},
					Getter = (object o) => ((CharacterJoint)o).swing2Limit,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimit swing2Limit = ((CharacterJoint)o).swing2Limit;
						if (!swing2Limit.Equals((SoftJointLimit)v))
						{
							v = swing2Limit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableProjection",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).enableProjection = (bool)v;
					},
					Getter = (object o) => ((CharacterJoint)o).enableProjection,
					Updater = delegate(object o, ref object v)
					{
						bool enableProjection = ((CharacterJoint)o).enableProjection;
						if (!enableProjection.Equals((bool)v))
						{
							v = enableProjection;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "projectionDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).projectionDistance = (float)v;
					},
					Getter = (object o) => ((CharacterJoint)o).projectionDistance,
					Updater = delegate(object o, ref object v)
					{
						float projectionDistance = ((CharacterJoint)o).projectionDistance;
						if (!projectionDistance.Equals((float)v))
						{
							v = projectionDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "projectionAngle",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).projectionAngle = (float)v;
					},
					Getter = (object o) => ((CharacterJoint)o).projectionAngle,
					Updater = delegate(object o, ref object v)
					{
						float projectionAngle = ((CharacterJoint)o).projectionAngle;
						if (!projectionAngle.Equals((float)v))
						{
							v = projectionAngle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).breakForce = (float)v;
					},
					Getter = (object o) => ((CharacterJoint)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((CharacterJoint)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).breakTorque = (float)v;
					},
					Getter = (object o) => ((CharacterJoint)o).breakTorque,
					Updater = delegate(object o, ref object v)
					{
						float breakTorque = ((CharacterJoint)o).breakTorque;
						if (!breakTorque.Equals((float)v))
						{
							v = breakTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((CharacterJoint)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((CharacterJoint)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enablePreprocessing",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).enablePreprocessing = (bool)v;
					},
					Getter = (object o) => ((CharacterJoint)o).enablePreprocessing,
					Updater = delegate(object o, ref object v)
					{
						bool enablePreprocessing = ((CharacterJoint)o).enablePreprocessing;
						if (!enablePreprocessing.Equals((bool)v))
						{
							v = enablePreprocessing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "massScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).massScale = (float)v;
					},
					Getter = (object o) => ((CharacterJoint)o).massScale,
					Updater = delegate(object o, ref object v)
					{
						float massScale = ((CharacterJoint)o).massScale;
						if (!massScale.Equals((float)v))
						{
							v = massScale;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedMassScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CharacterJoint)o).connectedMassScale = (float)v;
					},
					Getter = (object o) => ((CharacterJoint)o).connectedMassScale,
					Updater = delegate(object o, ref object v)
					{
						float connectedMassScale = ((CharacterJoint)o).connectedMassScale;
						if (!connectedMassScale.Equals((float)v))
						{
							v = connectedMassScale;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.CircleCollider2D",
			new ProximaComponentCommands.PropertyInfo[7]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterial",
					PropertyType = typeof(PhysicsMaterial2D),
					Setter = (object o, object v) =>
					{
						((CircleCollider2D)o).sharedMaterial = (PhysicsMaterial2D)v;
					},
					Getter = (object o) => ((CircleCollider2D)o).sharedMaterial
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTrigger",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CircleCollider2D)o).isTrigger = (bool)v;
					},
					Getter = (object o) => ((CircleCollider2D)o).isTrigger,
					Updater = delegate(object o, ref object v)
					{
						bool isTrigger = ((CircleCollider2D)o).isTrigger;
						if (!isTrigger.Equals((bool)v))
						{
							v = isTrigger;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByEffector",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CircleCollider2D)o).usedByEffector = (bool)v;
					},
					Getter = (object o) => ((CircleCollider2D)o).usedByEffector,
					Updater = delegate(object o, ref object v)
					{
						bool usedByEffector = ((CircleCollider2D)o).usedByEffector;
						if (!usedByEffector.Equals((bool)v))
						{
							v = usedByEffector;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByComposite",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CircleCollider2D)o).usedByComposite = (bool)v;
					},
					Getter = (object o) => ((CircleCollider2D)o).usedByComposite,
					Updater = delegate(object o, ref object v)
					{
						bool usedByComposite = ((CircleCollider2D)o).usedByComposite;
						if (!usedByComposite.Equals((bool)v))
						{
							v = usedByComposite;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "offset",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((CircleCollider2D)o).offset = (Vector2)v;
					},
					Getter = (object o) => ((CircleCollider2D)o).offset,
					Updater = delegate(object o, ref object v)
					{
						Vector2 offset = ((CircleCollider2D)o).offset;
						if (!offset.Equals((Vector2)v))
						{
							v = offset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "radius",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CircleCollider2D)o).radius = (float)v;
					},
					Getter = (object o) => ((CircleCollider2D)o).radius,
					Updater = delegate(object o, ref object v)
					{
						float radius = ((CircleCollider2D)o).radius;
						if (!radius.Equals((float)v))
						{
							v = radius;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CircleCollider2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((CircleCollider2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((CircleCollider2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Cloth",
			new ProximaComponentCommands.PropertyInfo[18]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "stretchingStiffness",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Cloth)o).stretchingStiffness = (float)v;
					},
					Getter = (object o) => ((Cloth)o).stretchingStiffness,
					Updater = delegate(object o, ref object v)
					{
						float stretchingStiffness = ((Cloth)o).stretchingStiffness;
						if (!stretchingStiffness.Equals((float)v))
						{
							v = stretchingStiffness;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "bendingStiffness",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Cloth)o).bendingStiffness = (float)v;
					},
					Getter = (object o) => ((Cloth)o).bendingStiffness,
					Updater = delegate(object o, ref object v)
					{
						float bendingStiffness = ((Cloth)o).bendingStiffness;
						if (!bendingStiffness.Equals((float)v))
						{
							v = bendingStiffness;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useTethers",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Cloth)o).useTethers = (bool)v;
					},
					Getter = (object o) => ((Cloth)o).useTethers,
					Updater = delegate(object o, ref object v)
					{
						bool useTethers = ((Cloth)o).useTethers;
						if (!useTethers.Equals((bool)v))
						{
							v = useTethers;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useGravity",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Cloth)o).useGravity = (bool)v;
					},
					Getter = (object o) => ((Cloth)o).useGravity,
					Updater = delegate(object o, ref object v)
					{
						bool useGravity = ((Cloth)o).useGravity;
						if (!useGravity.Equals((bool)v))
						{
							v = useGravity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "damping",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Cloth)o).damping = (float)v;
					},
					Getter = (object o) => ((Cloth)o).damping,
					Updater = delegate(object o, ref object v)
					{
						float damping = ((Cloth)o).damping;
						if (!damping.Equals((float)v))
						{
							v = damping;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "externalAcceleration",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((Cloth)o).externalAcceleration = (Vector3)v;
					},
					Getter = (object o) => ((Cloth)o).externalAcceleration,
					Updater = delegate(object o, ref object v)
					{
						Vector3 externalAcceleration = ((Cloth)o).externalAcceleration;
						if (!externalAcceleration.Equals((Vector3)v))
						{
							v = externalAcceleration;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "randomAcceleration",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((Cloth)o).randomAcceleration = (Vector3)v;
					},
					Getter = (object o) => ((Cloth)o).randomAcceleration,
					Updater = delegate(object o, ref object v)
					{
						Vector3 randomAcceleration = ((Cloth)o).randomAcceleration;
						if (!randomAcceleration.Equals((Vector3)v))
						{
							v = randomAcceleration;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "worldVelocityScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Cloth)o).worldVelocityScale = (float)v;
					},
					Getter = (object o) => ((Cloth)o).worldVelocityScale,
					Updater = delegate(object o, ref object v)
					{
						float worldVelocityScale = ((Cloth)o).worldVelocityScale;
						if (!worldVelocityScale.Equals((float)v))
						{
							v = worldVelocityScale;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "worldAccelerationScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Cloth)o).worldAccelerationScale = (float)v;
					},
					Getter = (object o) => ((Cloth)o).worldAccelerationScale,
					Updater = delegate(object o, ref object v)
					{
						float worldAccelerationScale = ((Cloth)o).worldAccelerationScale;
						if (!worldAccelerationScale.Equals((float)v))
						{
							v = worldAccelerationScale;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "friction",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Cloth)o).friction = (float)v;
					},
					Getter = (object o) => ((Cloth)o).friction,
					Updater = delegate(object o, ref object v)
					{
						float friction = ((Cloth)o).friction;
						if (!friction.Equals((float)v))
						{
							v = friction;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "collisionMassScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Cloth)o).collisionMassScale = (float)v;
					},
					Getter = (object o) => ((Cloth)o).collisionMassScale,
					Updater = delegate(object o, ref object v)
					{
						float collisionMassScale = ((Cloth)o).collisionMassScale;
						if (!collisionMassScale.Equals((float)v))
						{
							v = collisionMassScale;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableContinuousCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Cloth)o).enableContinuousCollision = (bool)v;
					},
					Getter = (object o) => ((Cloth)o).enableContinuousCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableContinuousCollision = ((Cloth)o).enableContinuousCollision;
						if (!enableContinuousCollision.Equals((bool)v))
						{
							v = enableContinuousCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useVirtualParticles",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Cloth)o).useVirtualParticles = (float)v;
					},
					Getter = (object o) => ((Cloth)o).useVirtualParticles,
					Updater = delegate(object o, ref object v)
					{
						float useVirtualParticles = ((Cloth)o).useVirtualParticles;
						if (!useVirtualParticles.Equals((float)v))
						{
							v = useVirtualParticles;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "clothSolverFrequency",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Cloth)o).clothSolverFrequency = (float)v;
					},
					Getter = (object o) => ((Cloth)o).clothSolverFrequency,
					Updater = delegate(object o, ref object v)
					{
						float clothSolverFrequency = ((Cloth)o).clothSolverFrequency;
						if (!clothSolverFrequency.Equals((float)v))
						{
							v = clothSolverFrequency;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sleepThreshold",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Cloth)o).sleepThreshold = (float)v;
					},
					Getter = (object o) => ((Cloth)o).sleepThreshold,
					Updater = delegate(object o, ref object v)
					{
						float sleepThreshold = ((Cloth)o).sleepThreshold;
						if (!sleepThreshold.Equals((float)v))
						{
							v = sleepThreshold;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "capsuleColliders",
					PropertyType = typeof(CapsuleCollider[]),
					Setter = (object o, object v) =>
					{
						((Cloth)o).capsuleColliders = (CapsuleCollider[])v;
					},
					Getter = (object o) => ((Cloth)o).capsuleColliders
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sphereColliders",
					PropertyType = typeof(ClothSphereColliderPair[]),
					Setter = (object o, object v) =>
					{
						((Cloth)o).sphereColliders = (ClothSphereColliderPair[])v;
					},
					Getter = (object o) => ((Cloth)o).sphereColliders
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Cloth)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Cloth)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Cloth)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.CompositeCollider2D",
			new ProximaComponentCommands.PropertyInfo[11]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterial",
					PropertyType = typeof(PhysicsMaterial2D),
					Setter = (object o, object v) =>
					{
						((CompositeCollider2D)o).sharedMaterial = (PhysicsMaterial2D)v;
					},
					Getter = (object o) => ((CompositeCollider2D)o).sharedMaterial
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTrigger",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CompositeCollider2D)o).isTrigger = (bool)v;
					},
					Getter = (object o) => ((CompositeCollider2D)o).isTrigger,
					Updater = delegate(object o, ref object v)
					{
						bool isTrigger = ((CompositeCollider2D)o).isTrigger;
						if (!isTrigger.Equals((bool)v))
						{
							v = isTrigger;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByEffector",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CompositeCollider2D)o).usedByEffector = (bool)v;
					},
					Getter = (object o) => ((CompositeCollider2D)o).usedByEffector,
					Updater = delegate(object o, ref object v)
					{
						bool usedByEffector = ((CompositeCollider2D)o).usedByEffector;
						if (!usedByEffector.Equals((bool)v))
						{
							v = usedByEffector;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByComposite",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CompositeCollider2D)o).usedByComposite = (bool)v;
					},
					Getter = (object o) => ((CompositeCollider2D)o).usedByComposite,
					Updater = delegate(object o, ref object v)
					{
						bool usedByComposite = ((CompositeCollider2D)o).usedByComposite;
						if (!usedByComposite.Equals((bool)v))
						{
							v = usedByComposite;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "offset",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((CompositeCollider2D)o).offset = (Vector2)v;
					},
					Getter = (object o) => ((CompositeCollider2D)o).offset,
					Updater = delegate(object o, ref object v)
					{
						Vector2 offset = ((CompositeCollider2D)o).offset;
						if (!offset.Equals((Vector2)v))
						{
							v = offset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "geometryType",
					PropertyType = typeof(CompositeCollider2D.GeometryType),
					Setter = (object o, object v) =>
					{
						((CompositeCollider2D)o).geometryType = (CompositeCollider2D.GeometryType)v;
					},
					Getter = (object o) => ((CompositeCollider2D)o).geometryType,
					Updater = delegate(object o, ref object v)
					{
						int geometryType = (int)((CompositeCollider2D)o).geometryType;
						if (!geometryType.Equals((int)v))
						{
							v = geometryType;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "generationType",
					PropertyType = typeof(CompositeCollider2D.GenerationType),
					Setter = (object o, object v) =>
					{
						((CompositeCollider2D)o).generationType = (CompositeCollider2D.GenerationType)v;
					},
					Getter = (object o) => ((CompositeCollider2D)o).generationType,
					Updater = delegate(object o, ref object v)
					{
						int generationType = (int)((CompositeCollider2D)o).generationType;
						if (!generationType.Equals((int)v))
						{
							v = generationType;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "vertexDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CompositeCollider2D)o).vertexDistance = (float)v;
					},
					Getter = (object o) => ((CompositeCollider2D)o).vertexDistance,
					Updater = delegate(object o, ref object v)
					{
						float vertexDistance = ((CompositeCollider2D)o).vertexDistance;
						if (!vertexDistance.Equals((float)v))
						{
							v = vertexDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "offsetDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CompositeCollider2D)o).offsetDistance = (float)v;
					},
					Getter = (object o) => ((CompositeCollider2D)o).offsetDistance,
					Updater = delegate(object o, ref object v)
					{
						float offsetDistance = ((CompositeCollider2D)o).offsetDistance;
						if (!offsetDistance.Equals((float)v))
						{
							v = offsetDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "edgeRadius",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((CompositeCollider2D)o).edgeRadius = (float)v;
					},
					Getter = (object o) => ((CompositeCollider2D)o).edgeRadius,
					Updater = delegate(object o, ref object v)
					{
						float edgeRadius = ((CompositeCollider2D)o).edgeRadius;
						if (!edgeRadius.Equals((float)v))
						{
							v = edgeRadius;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((CompositeCollider2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((CompositeCollider2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((CompositeCollider2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.ConfigurableJoint",
			new ProximaComponentCommands.PropertyInfo[42]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).connectedBody = (Rigidbody)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedArticulationBody",
					PropertyType = typeof(ArticulationBody),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).connectedArticulationBody = (ArticulationBody)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).connectedArticulationBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).anchor = (Vector3)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector3 anchor = ((ConfigurableJoint)o).anchor;
						if (!anchor.Equals((Vector3)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "axis",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).axis = (Vector3)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).axis,
					Updater = delegate(object o, ref object v)
					{
						Vector3 axis = ((ConfigurableJoint)o).axis;
						if (!axis.Equals((Vector3)v))
						{
							v = axis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureConnectedAnchor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).autoConfigureConnectedAnchor = (bool)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).autoConfigureConnectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureConnectedAnchor = ((ConfigurableJoint)o).autoConfigureConnectedAnchor;
						if (!autoConfigureConnectedAnchor.Equals((bool)v))
						{
							v = autoConfigureConnectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedAnchor",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).connectedAnchor = (Vector3)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).connectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						Vector3 connectedAnchor = ((ConfigurableJoint)o).connectedAnchor;
						if (!connectedAnchor.Equals((Vector3)v))
						{
							v = connectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "xMotion",
					PropertyType = typeof(ConfigurableJointMotion),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).xMotion = (ConfigurableJointMotion)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).xMotion,
					Updater = delegate(object o, ref object v)
					{
						int xMotion = (int)((ConfigurableJoint)o).xMotion;
						if (!xMotion.Equals((int)v))
						{
							v = xMotion;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "yMotion",
					PropertyType = typeof(ConfigurableJointMotion),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).yMotion = (ConfigurableJointMotion)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).yMotion,
					Updater = delegate(object o, ref object v)
					{
						int yMotion = (int)((ConfigurableJoint)o).yMotion;
						if (!yMotion.Equals((int)v))
						{
							v = yMotion;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "zMotion",
					PropertyType = typeof(ConfigurableJointMotion),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).zMotion = (ConfigurableJointMotion)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).zMotion,
					Updater = delegate(object o, ref object v)
					{
						int zMotion = (int)((ConfigurableJoint)o).zMotion;
						if (!zMotion.Equals((int)v))
						{
							v = zMotion;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularXMotion",
					PropertyType = typeof(ConfigurableJointMotion),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).angularXMotion = (ConfigurableJointMotion)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).angularXMotion,
					Updater = delegate(object o, ref object v)
					{
						int angularXMotion = (int)((ConfigurableJoint)o).angularXMotion;
						if (!angularXMotion.Equals((int)v))
						{
							v = angularXMotion;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularYMotion",
					PropertyType = typeof(ConfigurableJointMotion),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).angularYMotion = (ConfigurableJointMotion)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).angularYMotion,
					Updater = delegate(object o, ref object v)
					{
						int angularYMotion = (int)((ConfigurableJoint)o).angularYMotion;
						if (!angularYMotion.Equals((int)v))
						{
							v = angularYMotion;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularZMotion",
					PropertyType = typeof(ConfigurableJointMotion),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).angularZMotion = (ConfigurableJointMotion)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).angularZMotion,
					Updater = delegate(object o, ref object v)
					{
						int angularZMotion = (int)((ConfigurableJoint)o).angularZMotion;
						if (!angularZMotion.Equals((int)v))
						{
							v = angularZMotion;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "linearLimitSpring",
					PropertyType = typeof(SoftJointLimitSpring),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).linearLimitSpring = (SoftJointLimitSpring)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).linearLimitSpring,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimitSpring linearLimitSpring = ((ConfigurableJoint)o).linearLimitSpring;
						if (!linearLimitSpring.Equals((SoftJointLimitSpring)v))
						{
							v = linearLimitSpring;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "linearLimit",
					PropertyType = typeof(SoftJointLimit),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).linearLimit = (SoftJointLimit)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).linearLimit,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimit linearLimit = ((ConfigurableJoint)o).linearLimit;
						if (!linearLimit.Equals((SoftJointLimit)v))
						{
							v = linearLimit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularXLimitSpring",
					PropertyType = typeof(SoftJointLimitSpring),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).angularXLimitSpring = (SoftJointLimitSpring)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).angularXLimitSpring,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimitSpring angularXLimitSpring = ((ConfigurableJoint)o).angularXLimitSpring;
						if (!angularXLimitSpring.Equals((SoftJointLimitSpring)v))
						{
							v = angularXLimitSpring;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lowAngularXLimit",
					PropertyType = typeof(SoftJointLimit),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).lowAngularXLimit = (SoftJointLimit)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).lowAngularXLimit,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimit lowAngularXLimit = ((ConfigurableJoint)o).lowAngularXLimit;
						if (!lowAngularXLimit.Equals((SoftJointLimit)v))
						{
							v = lowAngularXLimit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "highAngularXLimit",
					PropertyType = typeof(SoftJointLimit),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).highAngularXLimit = (SoftJointLimit)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).highAngularXLimit,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimit highAngularXLimit = ((ConfigurableJoint)o).highAngularXLimit;
						if (!highAngularXLimit.Equals((SoftJointLimit)v))
						{
							v = highAngularXLimit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularYZLimitSpring",
					PropertyType = typeof(SoftJointLimitSpring),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).angularYZLimitSpring = (SoftJointLimitSpring)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).angularYZLimitSpring,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimitSpring angularYZLimitSpring = ((ConfigurableJoint)o).angularYZLimitSpring;
						if (!angularYZLimitSpring.Equals((SoftJointLimitSpring)v))
						{
							v = angularYZLimitSpring;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularYLimit",
					PropertyType = typeof(SoftJointLimit),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).angularYLimit = (SoftJointLimit)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).angularYLimit,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimit angularYLimit = ((ConfigurableJoint)o).angularYLimit;
						if (!angularYLimit.Equals((SoftJointLimit)v))
						{
							v = angularYLimit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularZLimit",
					PropertyType = typeof(SoftJointLimit),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).angularZLimit = (SoftJointLimit)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).angularZLimit,
					Updater = delegate(object o, ref object v)
					{
						SoftJointLimit angularZLimit = ((ConfigurableJoint)o).angularZLimit;
						if (!angularZLimit.Equals((SoftJointLimit)v))
						{
							v = angularZLimit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetPosition",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).targetPosition = (Vector3)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).targetPosition,
					Updater = delegate(object o, ref object v)
					{
						Vector3 targetPosition = ((ConfigurableJoint)o).targetPosition;
						if (!targetPosition.Equals((Vector3)v))
						{
							v = targetPosition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetVelocity",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).targetVelocity = (Vector3)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).targetVelocity,
					Updater = delegate(object o, ref object v)
					{
						Vector3 targetVelocity = ((ConfigurableJoint)o).targetVelocity;
						if (!targetVelocity.Equals((Vector3)v))
						{
							v = targetVelocity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "xDrive",
					PropertyType = typeof(JointDrive),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).xDrive = (JointDrive)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).xDrive,
					Updater = delegate(object o, ref object v)
					{
						JointDrive xDrive = ((ConfigurableJoint)o).xDrive;
						if (!xDrive.Equals((JointDrive)v))
						{
							v = xDrive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "yDrive",
					PropertyType = typeof(JointDrive),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).yDrive = (JointDrive)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).yDrive,
					Updater = delegate(object o, ref object v)
					{
						JointDrive yDrive = ((ConfigurableJoint)o).yDrive;
						if (!yDrive.Equals((JointDrive)v))
						{
							v = yDrive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "zDrive",
					PropertyType = typeof(JointDrive),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).zDrive = (JointDrive)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).zDrive,
					Updater = delegate(object o, ref object v)
					{
						JointDrive zDrive = ((ConfigurableJoint)o).zDrive;
						if (!zDrive.Equals((JointDrive)v))
						{
							v = zDrive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetRotation",
					PropertyType = typeof(Quaternion),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).targetRotation = (Quaternion)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).targetRotation,
					Updater = delegate(object o, ref object v)
					{
						Quaternion targetRotation = ((ConfigurableJoint)o).targetRotation;
						if (!targetRotation.Equals((Quaternion)v))
						{
							v = targetRotation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetAngularVelocity",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).targetAngularVelocity = (Vector3)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).targetAngularVelocity,
					Updater = delegate(object o, ref object v)
					{
						Vector3 targetAngularVelocity = ((ConfigurableJoint)o).targetAngularVelocity;
						if (!targetAngularVelocity.Equals((Vector3)v))
						{
							v = targetAngularVelocity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationDriveMode",
					PropertyType = typeof(RotationDriveMode),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).rotationDriveMode = (RotationDriveMode)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).rotationDriveMode,
					Updater = delegate(object o, ref object v)
					{
						int rotationDriveMode = (int)((ConfigurableJoint)o).rotationDriveMode;
						if (!rotationDriveMode.Equals((int)v))
						{
							v = rotationDriveMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularXDrive",
					PropertyType = typeof(JointDrive),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).angularXDrive = (JointDrive)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).angularXDrive,
					Updater = delegate(object o, ref object v)
					{
						JointDrive angularXDrive = ((ConfigurableJoint)o).angularXDrive;
						if (!angularXDrive.Equals((JointDrive)v))
						{
							v = angularXDrive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularYZDrive",
					PropertyType = typeof(JointDrive),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).angularYZDrive = (JointDrive)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).angularYZDrive,
					Updater = delegate(object o, ref object v)
					{
						JointDrive angularYZDrive = ((ConfigurableJoint)o).angularYZDrive;
						if (!angularYZDrive.Equals((JointDrive)v))
						{
							v = angularYZDrive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "slerpDrive",
					PropertyType = typeof(JointDrive),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).slerpDrive = (JointDrive)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).slerpDrive,
					Updater = delegate(object o, ref object v)
					{
						JointDrive slerpDrive = ((ConfigurableJoint)o).slerpDrive;
						if (!slerpDrive.Equals((JointDrive)v))
						{
							v = slerpDrive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "projectionMode",
					PropertyType = typeof(JointProjectionMode),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).projectionMode = (JointProjectionMode)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).projectionMode,
					Updater = delegate(object o, ref object v)
					{
						int projectionMode = (int)((ConfigurableJoint)o).projectionMode;
						if (!projectionMode.Equals((int)v))
						{
							v = projectionMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "projectionDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).projectionDistance = (float)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).projectionDistance,
					Updater = delegate(object o, ref object v)
					{
						float projectionDistance = ((ConfigurableJoint)o).projectionDistance;
						if (!projectionDistance.Equals((float)v))
						{
							v = projectionDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "projectionAngle",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).projectionAngle = (float)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).projectionAngle,
					Updater = delegate(object o, ref object v)
					{
						float projectionAngle = ((ConfigurableJoint)o).projectionAngle;
						if (!projectionAngle.Equals((float)v))
						{
							v = projectionAngle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "configuredInWorldSpace",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).configuredInWorldSpace = (bool)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).configuredInWorldSpace,
					Updater = delegate(object o, ref object v)
					{
						bool configuredInWorldSpace = ((ConfigurableJoint)o).configuredInWorldSpace;
						if (!configuredInWorldSpace.Equals((bool)v))
						{
							v = configuredInWorldSpace;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "swapBodies",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).swapBodies = (bool)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).swapBodies,
					Updater = delegate(object o, ref object v)
					{
						bool swapBodies = ((ConfigurableJoint)o).swapBodies;
						if (!swapBodies.Equals((bool)v))
						{
							v = swapBodies;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).breakForce = (float)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((ConfigurableJoint)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).breakTorque = (float)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).breakTorque,
					Updater = delegate(object o, ref object v)
					{
						float breakTorque = ((ConfigurableJoint)o).breakTorque;
						if (!breakTorque.Equals((float)v))
						{
							v = breakTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((ConfigurableJoint)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enablePreprocessing",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).enablePreprocessing = (bool)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).enablePreprocessing,
					Updater = delegate(object o, ref object v)
					{
						bool enablePreprocessing = ((ConfigurableJoint)o).enablePreprocessing;
						if (!enablePreprocessing.Equals((bool)v))
						{
							v = enablePreprocessing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "massScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).massScale = (float)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).massScale,
					Updater = delegate(object o, ref object v)
					{
						float massScale = ((ConfigurableJoint)o).massScale;
						if (!massScale.Equals((float)v))
						{
							v = massScale;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedMassScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ConfigurableJoint)o).connectedMassScale = (float)v;
					},
					Getter = (object o) => ((ConfigurableJoint)o).connectedMassScale,
					Updater = delegate(object o, ref object v)
					{
						float connectedMassScale = ((ConfigurableJoint)o).connectedMassScale;
						if (!connectedMassScale.Equals((float)v))
						{
							v = connectedMassScale;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.ConstantForce",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "force",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ConstantForce)o).force = (Vector3)v;
					},
					Getter = (object o) => ((ConstantForce)o).force,
					Updater = delegate(object o, ref object v)
					{
						Vector3 force = ((ConstantForce)o).force;
						if (!force.Equals((Vector3)v))
						{
							v = force;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "relativeForce",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ConstantForce)o).relativeForce = (Vector3)v;
					},
					Getter = (object o) => ((ConstantForce)o).relativeForce,
					Updater = delegate(object o, ref object v)
					{
						Vector3 relativeForce = ((ConstantForce)o).relativeForce;
						if (!relativeForce.Equals((Vector3)v))
						{
							v = relativeForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "torque",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ConstantForce)o).torque = (Vector3)v;
					},
					Getter = (object o) => ((ConstantForce)o).torque,
					Updater = delegate(object o, ref object v)
					{
						Vector3 torque = ((ConstantForce)o).torque;
						if (!torque.Equals((Vector3)v))
						{
							v = torque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "relativeTorque",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ConstantForce)o).relativeTorque = (Vector3)v;
					},
					Getter = (object o) => ((ConstantForce)o).relativeTorque,
					Updater = delegate(object o, ref object v)
					{
						Vector3 relativeTorque = ((ConstantForce)o).relativeTorque;
						if (!relativeTorque.Equals((Vector3)v))
						{
							v = relativeTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ConstantForce)o).enabled = (bool)v;
					},
					Getter = (object o) => ((ConstantForce)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((ConstantForce)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.ConstantForce2D",
			new ProximaComponentCommands.PropertyInfo[4]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "force",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((ConstantForce2D)o).force = (Vector2)v;
					},
					Getter = (object o) => ((ConstantForce2D)o).force,
					Updater = delegate(object o, ref object v)
					{
						Vector2 force = ((ConstantForce2D)o).force;
						if (!force.Equals((Vector2)v))
						{
							v = force;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "relativeForce",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((ConstantForce2D)o).relativeForce = (Vector2)v;
					},
					Getter = (object o) => ((ConstantForce2D)o).relativeForce,
					Updater = delegate(object o, ref object v)
					{
						Vector2 relativeForce = ((ConstantForce2D)o).relativeForce;
						if (!relativeForce.Equals((Vector2)v))
						{
							v = relativeForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "torque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ConstantForce2D)o).torque = (float)v;
					},
					Getter = (object o) => ((ConstantForce2D)o).torque,
					Updater = delegate(object o, ref object v)
					{
						float torque = ((ConstantForce2D)o).torque;
						if (!torque.Equals((float)v))
						{
							v = torque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ConstantForce2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((ConstantForce2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((ConstantForce2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.ContentSizeFitter",
			new ProximaComponentCommands.PropertyInfo[3]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "horizontalFit",
					PropertyType = typeof(ContentSizeFitter.FitMode),
					Setter = (object o, object v) =>
					{
						((ContentSizeFitter)o).horizontalFit = (ContentSizeFitter.FitMode)v;
					},
					Getter = (object o) => ((ContentSizeFitter)o).horizontalFit,
					Updater = delegate(object o, ref object v)
					{
						int horizontalFit = (int)((ContentSizeFitter)o).horizontalFit;
						if (!horizontalFit.Equals((int)v))
						{
							v = horizontalFit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "verticalFit",
					PropertyType = typeof(ContentSizeFitter.FitMode),
					Setter = (object o, object v) =>
					{
						((ContentSizeFitter)o).verticalFit = (ContentSizeFitter.FitMode)v;
					},
					Getter = (object o) => ((ContentSizeFitter)o).verticalFit,
					Updater = delegate(object o, ref object v)
					{
						int verticalFit = (int)((ContentSizeFitter)o).verticalFit;
						if (!verticalFit.Equals((int)v))
						{
							v = verticalFit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ContentSizeFitter)o).enabled = (bool)v;
					},
					Getter = (object o) => ((ContentSizeFitter)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((ContentSizeFitter)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.DistanceJoint2D",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((DistanceJoint2D)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((DistanceJoint2D)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((DistanceJoint2D)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody2D),
					Setter = (object o, object v) =>
					{
						((DistanceJoint2D)o).connectedBody = (Rigidbody2D)v;
					},
					Getter = (object o) => ((DistanceJoint2D)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureConnectedAnchor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((DistanceJoint2D)o).autoConfigureConnectedAnchor = (bool)v;
					},
					Getter = (object o) => ((DistanceJoint2D)o).autoConfigureConnectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureConnectedAnchor = ((DistanceJoint2D)o).autoConfigureConnectedAnchor;
						if (!autoConfigureConnectedAnchor.Equals((bool)v))
						{
							v = autoConfigureConnectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((DistanceJoint2D)o).anchor = (Vector2)v;
					},
					Getter = (object o) => ((DistanceJoint2D)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 anchor = ((DistanceJoint2D)o).anchor;
						if (!anchor.Equals((Vector2)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedAnchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((DistanceJoint2D)o).connectedAnchor = (Vector2)v;
					},
					Getter = (object o) => ((DistanceJoint2D)o).connectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 connectedAnchor = ((DistanceJoint2D)o).connectedAnchor;
						if (!connectedAnchor.Equals((Vector2)v))
						{
							v = connectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureDistance",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((DistanceJoint2D)o).autoConfigureDistance = (bool)v;
					},
					Getter = (object o) => ((DistanceJoint2D)o).autoConfigureDistance,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureDistance = ((DistanceJoint2D)o).autoConfigureDistance;
						if (!autoConfigureDistance.Equals((bool)v))
						{
							v = autoConfigureDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "distance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((DistanceJoint2D)o).distance = (float)v;
					},
					Getter = (object o) => ((DistanceJoint2D)o).distance,
					Updater = delegate(object o, ref object v)
					{
						float distance = ((DistanceJoint2D)o).distance;
						if (!distance.Equals((float)v))
						{
							v = distance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxDistanceOnly",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((DistanceJoint2D)o).maxDistanceOnly = (bool)v;
					},
					Getter = (object o) => ((DistanceJoint2D)o).maxDistanceOnly,
					Updater = delegate(object o, ref object v)
					{
						bool maxDistanceOnly = ((DistanceJoint2D)o).maxDistanceOnly;
						if (!maxDistanceOnly.Equals((bool)v))
						{
							v = maxDistanceOnly;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((DistanceJoint2D)o).breakForce = (float)v;
					},
					Getter = (object o) => ((DistanceJoint2D)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((DistanceJoint2D)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((DistanceJoint2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((DistanceJoint2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((DistanceJoint2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.Dropdown",
			new ProximaComponentCommands.PropertyInfo[14]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "interactable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).interactable = (bool)v;
					},
					Getter = (object o) => ((Dropdown)o).interactable,
					Updater = delegate(object o, ref object v)
					{
						bool interactable = ((Dropdown)o).interactable;
						if (!interactable.Equals((bool)v))
						{
							v = interactable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "transition",
					PropertyType = typeof(Selectable.Transition),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).transition = (Selectable.Transition)v;
					},
					Getter = (object o) => ((Dropdown)o).transition,
					Updater = delegate(object o, ref object v)
					{
						int transition = (int)((Dropdown)o).transition;
						if (!transition.Equals((int)v))
						{
							v = transition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetGraphic",
					PropertyType = typeof(Graphic),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).targetGraphic = (Graphic)v;
					},
					Getter = (object o) => ((Dropdown)o).targetGraphic
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colors",
					PropertyType = typeof(ColorBlock),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).colors = (ColorBlock)v;
					},
					Getter = (object o) => ((Dropdown)o).colors,
					Updater = delegate(object o, ref object v)
					{
						ColorBlock colors = ((Dropdown)o).colors;
						if (!colors.Equals((ColorBlock)v))
						{
							v = colors;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "navigation",
					PropertyType = typeof(Navigation),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).navigation = (Navigation)v;
					},
					Getter = (object o) => ((Dropdown)o).navigation,
					Updater = delegate(object o, ref object v)
					{
						Navigation navigation = ((Dropdown)o).navigation;
						if (!navigation.Equals((Navigation)v))
						{
							v = navigation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "template",
					PropertyType = typeof(RectTransform),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).template = (RectTransform)v;
					},
					Getter = (object o) => ((Dropdown)o).template
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "captionText",
					PropertyType = typeof(Text),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).captionText = (Text)v;
					},
					Getter = (object o) => ((Dropdown)o).captionText
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "captionImage",
					PropertyType = typeof(UnityEngine.UI.Image),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).captionImage = (UnityEngine.UI.Image)v;
					},
					Getter = (object o) => ((Dropdown)o).captionImage
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "itemText",
					PropertyType = typeof(Text),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).itemText = (Text)v;
					},
					Getter = (object o) => ((Dropdown)o).itemText
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "itemImage",
					PropertyType = typeof(UnityEngine.UI.Image),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).itemImage = (UnityEngine.UI.Image)v;
					},
					Getter = (object o) => ((Dropdown)o).itemImage
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "value",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).value = (int)v;
					},
					Getter = (object o) => ((Dropdown)o).value,
					Updater = delegate(object o, ref object v)
					{
						int value = ((Dropdown)o).value;
						if (!value.Equals((int)v))
						{
							v = value;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "alphaFadeSpeed",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).alphaFadeSpeed = (float)v;
					},
					Getter = (object o) => ((Dropdown)o).alphaFadeSpeed,
					Updater = delegate(object o, ref object v)
					{
						float alphaFadeSpeed = ((Dropdown)o).alphaFadeSpeed;
						if (!alphaFadeSpeed.Equals((float)v))
						{
							v = alphaFadeSpeed;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "options",
					PropertyType = typeof(List<Dropdown.OptionData>),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).options = (List<Dropdown.OptionData>)v;
					},
					Getter = (object o) => ((Dropdown)o).options
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Dropdown)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Dropdown)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Dropdown)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.EdgeCollider2D",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterial",
					PropertyType = typeof(PhysicsMaterial2D),
					Setter = (object o, object v) =>
					{
						((EdgeCollider2D)o).sharedMaterial = (PhysicsMaterial2D)v;
					},
					Getter = (object o) => ((EdgeCollider2D)o).sharedMaterial
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTrigger",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((EdgeCollider2D)o).isTrigger = (bool)v;
					},
					Getter = (object o) => ((EdgeCollider2D)o).isTrigger,
					Updater = delegate(object o, ref object v)
					{
						bool isTrigger = ((EdgeCollider2D)o).isTrigger;
						if (!isTrigger.Equals((bool)v))
						{
							v = isTrigger;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByEffector",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((EdgeCollider2D)o).usedByEffector = (bool)v;
					},
					Getter = (object o) => ((EdgeCollider2D)o).usedByEffector,
					Updater = delegate(object o, ref object v)
					{
						bool usedByEffector = ((EdgeCollider2D)o).usedByEffector;
						if (!usedByEffector.Equals((bool)v))
						{
							v = usedByEffector;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByComposite",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((EdgeCollider2D)o).usedByComposite = (bool)v;
					},
					Getter = (object o) => ((EdgeCollider2D)o).usedByComposite,
					Updater = delegate(object o, ref object v)
					{
						bool usedByComposite = ((EdgeCollider2D)o).usedByComposite;
						if (!usedByComposite.Equals((bool)v))
						{
							v = usedByComposite;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "offset",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((EdgeCollider2D)o).offset = (Vector2)v;
					},
					Getter = (object o) => ((EdgeCollider2D)o).offset,
					Updater = delegate(object o, ref object v)
					{
						Vector2 offset = ((EdgeCollider2D)o).offset;
						if (!offset.Equals((Vector2)v))
						{
							v = offset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "edgeRadius",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((EdgeCollider2D)o).edgeRadius = (float)v;
					},
					Getter = (object o) => ((EdgeCollider2D)o).edgeRadius,
					Updater = delegate(object o, ref object v)
					{
						float edgeRadius = ((EdgeCollider2D)o).edgeRadius;
						if (!edgeRadius.Equals((float)v))
						{
							v = edgeRadius;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "points",
					PropertyType = typeof(Vector2[]),
					Setter = (object o, object v) =>
					{
						((EdgeCollider2D)o).points = (Vector2[])v;
					},
					Getter = (object o) => ((EdgeCollider2D)o).points
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useAdjacentStartPoint",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((EdgeCollider2D)o).useAdjacentStartPoint = (bool)v;
					},
					Getter = (object o) => ((EdgeCollider2D)o).useAdjacentStartPoint,
					Updater = delegate(object o, ref object v)
					{
						bool useAdjacentStartPoint = ((EdgeCollider2D)o).useAdjacentStartPoint;
						if (!useAdjacentStartPoint.Equals((bool)v))
						{
							v = useAdjacentStartPoint;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useAdjacentEndPoint",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((EdgeCollider2D)o).useAdjacentEndPoint = (bool)v;
					},
					Getter = (object o) => ((EdgeCollider2D)o).useAdjacentEndPoint,
					Updater = delegate(object o, ref object v)
					{
						bool useAdjacentEndPoint = ((EdgeCollider2D)o).useAdjacentEndPoint;
						if (!useAdjacentEndPoint.Equals((bool)v))
						{
							v = useAdjacentEndPoint;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((EdgeCollider2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((EdgeCollider2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((EdgeCollider2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.EventSystems.EventSystem",
			new ProximaComponentCommands.PropertyInfo[4]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "firstSelectedGameObject",
					PropertyType = typeof(GameObject),
					Setter = (object o, object v) =>
					{
						((EventSystem)o).firstSelectedGameObject = (GameObject)v;
					},
					Getter = (object o) => ((EventSystem)o).firstSelectedGameObject
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sendNavigationEvents",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((EventSystem)o).sendNavigationEvents = (bool)v;
					},
					Getter = (object o) => ((EventSystem)o).sendNavigationEvents,
					Updater = delegate(object o, ref object v)
					{
						bool sendNavigationEvents = ((EventSystem)o).sendNavigationEvents;
						if (!sendNavigationEvents.Equals((bool)v))
						{
							v = sendNavigationEvents;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "pixelDragThreshold",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((EventSystem)o).pixelDragThreshold = (int)v;
					},
					Getter = (object o) => ((EventSystem)o).pixelDragThreshold,
					Updater = delegate(object o, ref object v)
					{
						int pixelDragThreshold = ((EventSystem)o).pixelDragThreshold;
						if (!pixelDragThreshold.Equals((int)v))
						{
							v = pixelDragThreshold;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((EventSystem)o).enabled = (bool)v;
					},
					Getter = (object o) => ((EventSystem)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((EventSystem)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.FixedJoint2D",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((FixedJoint2D)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((FixedJoint2D)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((FixedJoint2D)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody2D),
					Setter = (object o, object v) =>
					{
						((FixedJoint2D)o).connectedBody = (Rigidbody2D)v;
					},
					Getter = (object o) => ((FixedJoint2D)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureConnectedAnchor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((FixedJoint2D)o).autoConfigureConnectedAnchor = (bool)v;
					},
					Getter = (object o) => ((FixedJoint2D)o).autoConfigureConnectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureConnectedAnchor = ((FixedJoint2D)o).autoConfigureConnectedAnchor;
						if (!autoConfigureConnectedAnchor.Equals((bool)v))
						{
							v = autoConfigureConnectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((FixedJoint2D)o).anchor = (Vector2)v;
					},
					Getter = (object o) => ((FixedJoint2D)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 anchor = ((FixedJoint2D)o).anchor;
						if (!anchor.Equals((Vector2)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedAnchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((FixedJoint2D)o).connectedAnchor = (Vector2)v;
					},
					Getter = (object o) => ((FixedJoint2D)o).connectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 connectedAnchor = ((FixedJoint2D)o).connectedAnchor;
						if (!connectedAnchor.Equals((Vector2)v))
						{
							v = connectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "dampingRatio",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((FixedJoint2D)o).dampingRatio = (float)v;
					},
					Getter = (object o) => ((FixedJoint2D)o).dampingRatio,
					Updater = delegate(object o, ref object v)
					{
						float dampingRatio = ((FixedJoint2D)o).dampingRatio;
						if (!dampingRatio.Equals((float)v))
						{
							v = dampingRatio;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "frequency",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((FixedJoint2D)o).frequency = (float)v;
					},
					Getter = (object o) => ((FixedJoint2D)o).frequency,
					Updater = delegate(object o, ref object v)
					{
						float frequency = ((FixedJoint2D)o).frequency;
						if (!frequency.Equals((float)v))
						{
							v = frequency;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((FixedJoint2D)o).breakForce = (float)v;
					},
					Getter = (object o) => ((FixedJoint2D)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((FixedJoint2D)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((FixedJoint2D)o).breakTorque = (float)v;
					},
					Getter = (object o) => ((FixedJoint2D)o).breakTorque,
					Updater = delegate(object o, ref object v)
					{
						float breakTorque = ((FixedJoint2D)o).breakTorque;
						if (!breakTorque.Equals((float)v))
						{
							v = breakTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((FixedJoint2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((FixedJoint2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((FixedJoint2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.FrictionJoint2D",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((FrictionJoint2D)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((FrictionJoint2D)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((FrictionJoint2D)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody2D),
					Setter = (object o, object v) =>
					{
						((FrictionJoint2D)o).connectedBody = (Rigidbody2D)v;
					},
					Getter = (object o) => ((FrictionJoint2D)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureConnectedAnchor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((FrictionJoint2D)o).autoConfigureConnectedAnchor = (bool)v;
					},
					Getter = (object o) => ((FrictionJoint2D)o).autoConfigureConnectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureConnectedAnchor = ((FrictionJoint2D)o).autoConfigureConnectedAnchor;
						if (!autoConfigureConnectedAnchor.Equals((bool)v))
						{
							v = autoConfigureConnectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((FrictionJoint2D)o).anchor = (Vector2)v;
					},
					Getter = (object o) => ((FrictionJoint2D)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 anchor = ((FrictionJoint2D)o).anchor;
						if (!anchor.Equals((Vector2)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedAnchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((FrictionJoint2D)o).connectedAnchor = (Vector2)v;
					},
					Getter = (object o) => ((FrictionJoint2D)o).connectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 connectedAnchor = ((FrictionJoint2D)o).connectedAnchor;
						if (!connectedAnchor.Equals((Vector2)v))
						{
							v = connectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((FrictionJoint2D)o).maxForce = (float)v;
					},
					Getter = (object o) => ((FrictionJoint2D)o).maxForce,
					Updater = delegate(object o, ref object v)
					{
						float maxForce = ((FrictionJoint2D)o).maxForce;
						if (!maxForce.Equals((float)v))
						{
							v = maxForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((FrictionJoint2D)o).maxTorque = (float)v;
					},
					Getter = (object o) => ((FrictionJoint2D)o).maxTorque,
					Updater = delegate(object o, ref object v)
					{
						float maxTorque = ((FrictionJoint2D)o).maxTorque;
						if (!maxTorque.Equals((float)v))
						{
							v = maxTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((FrictionJoint2D)o).breakForce = (float)v;
					},
					Getter = (object o) => ((FrictionJoint2D)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((FrictionJoint2D)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((FrictionJoint2D)o).breakTorque = (float)v;
					},
					Getter = (object o) => ((FrictionJoint2D)o).breakTorque,
					Updater = delegate(object o, ref object v)
					{
						float breakTorque = ((FrictionJoint2D)o).breakTorque;
						if (!breakTorque.Equals((float)v))
						{
							v = breakTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((FrictionJoint2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((FrictionJoint2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((FrictionJoint2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.GraphicRaycaster",
			new ProximaComponentCommands.PropertyInfo[4]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "ignoreReversedGraphics",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((GraphicRaycaster)o).ignoreReversedGraphics = (bool)v;
					},
					Getter = (object o) => ((GraphicRaycaster)o).ignoreReversedGraphics,
					Updater = delegate(object o, ref object v)
					{
						bool ignoreReversedGraphics = ((GraphicRaycaster)o).ignoreReversedGraphics;
						if (!ignoreReversedGraphics.Equals((bool)v))
						{
							v = ignoreReversedGraphics;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "blockingObjects",
					PropertyType = typeof(GraphicRaycaster.BlockingObjects),
					Setter = (object o, object v) =>
					{
						((GraphicRaycaster)o).blockingObjects = (GraphicRaycaster.BlockingObjects)v;
					},
					Getter = (object o) => ((GraphicRaycaster)o).blockingObjects,
					Updater = delegate(object o, ref object v)
					{
						int blockingObjects = (int)((GraphicRaycaster)o).blockingObjects;
						if (!blockingObjects.Equals((int)v))
						{
							v = blockingObjects;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "blockingMask",
					PropertyType = typeof(LayerMask),
					Setter = (object o, object v) =>
					{
						((GraphicRaycaster)o).blockingMask = (LayerMask)v;
					},
					Getter = (object o) => ((GraphicRaycaster)o).blockingMask,
					Updater = delegate(object o, ref object v)
					{
						LayerMask blockingMask = ((GraphicRaycaster)o).blockingMask;
						if (!blockingMask.Equals((LayerMask)v))
						{
							v = blockingMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((GraphicRaycaster)o).enabled = (bool)v;
					},
					Getter = (object o) => ((GraphicRaycaster)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((GraphicRaycaster)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Grid",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cellSize",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((Grid)o).cellSize = (Vector3)v;
					},
					Getter = (object o) => ((Grid)o).cellSize,
					Updater = delegate(object o, ref object v)
					{
						Vector3 cellSize = ((Grid)o).cellSize;
						if (!cellSize.Equals((Vector3)v))
						{
							v = cellSize;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cellGap",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((Grid)o).cellGap = (Vector3)v;
					},
					Getter = (object o) => ((Grid)o).cellGap,
					Updater = delegate(object o, ref object v)
					{
						Vector3 cellGap = ((Grid)o).cellGap;
						if (!cellGap.Equals((Vector3)v))
						{
							v = cellGap;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cellLayout",
					PropertyType = typeof(GridLayout.CellLayout),
					Setter = (object o, object v) =>
					{
						((Grid)o).cellLayout = (GridLayout.CellLayout)v;
					},
					Getter = (object o) => ((Grid)o).cellLayout,
					Updater = delegate(object o, ref object v)
					{
						int cellLayout = (int)((Grid)o).cellLayout;
						if (!cellLayout.Equals((int)v))
						{
							v = cellLayout;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cellSwizzle",
					PropertyType = typeof(GridLayout.CellSwizzle),
					Setter = (object o, object v) =>
					{
						((Grid)o).cellSwizzle = (GridLayout.CellSwizzle)v;
					},
					Getter = (object o) => ((Grid)o).cellSwizzle,
					Updater = delegate(object o, ref object v)
					{
						int cellSwizzle = (int)((Grid)o).cellSwizzle;
						if (!cellSwizzle.Equals((int)v))
						{
							v = cellSwizzle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Grid)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Grid)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Grid)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.GridLayoutGroup",
			new ProximaComponentCommands.PropertyInfo[8]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "padding",
					PropertyType = typeof(RectOffset),
					Setter = (object o, object v) =>
					{
						((GridLayoutGroup)o).padding = (RectOffset)v;
					},
					Getter = (object o) => ((GridLayoutGroup)o).padding
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cellSize",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((GridLayoutGroup)o).cellSize = (Vector2)v;
					},
					Getter = (object o) => ((GridLayoutGroup)o).cellSize,
					Updater = delegate(object o, ref object v)
					{
						Vector2 cellSize = ((GridLayoutGroup)o).cellSize;
						if (!cellSize.Equals((Vector2)v))
						{
							v = cellSize;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spacing",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((GridLayoutGroup)o).spacing = (Vector2)v;
					},
					Getter = (object o) => ((GridLayoutGroup)o).spacing,
					Updater = delegate(object o, ref object v)
					{
						Vector2 spacing = ((GridLayoutGroup)o).spacing;
						if (!spacing.Equals((Vector2)v))
						{
							v = spacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "startCorner",
					PropertyType = typeof(GridLayoutGroup.Corner),
					Setter = (object o, object v) =>
					{
						((GridLayoutGroup)o).startCorner = (GridLayoutGroup.Corner)v;
					},
					Getter = (object o) => ((GridLayoutGroup)o).startCorner,
					Updater = delegate(object o, ref object v)
					{
						int startCorner = (int)((GridLayoutGroup)o).startCorner;
						if (!startCorner.Equals((int)v))
						{
							v = startCorner;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "startAxis",
					PropertyType = typeof(GridLayoutGroup.Axis),
					Setter = (object o, object v) =>
					{
						((GridLayoutGroup)o).startAxis = (GridLayoutGroup.Axis)v;
					},
					Getter = (object o) => ((GridLayoutGroup)o).startAxis,
					Updater = delegate(object o, ref object v)
					{
						int startAxis = (int)((GridLayoutGroup)o).startAxis;
						if (!startAxis.Equals((int)v))
						{
							v = startAxis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childAlignment",
					PropertyType = typeof(TextAnchor),
					Setter = (object o, object v) =>
					{
						((GridLayoutGroup)o).childAlignment = (TextAnchor)v;
					},
					Getter = (object o) => ((GridLayoutGroup)o).childAlignment,
					Updater = delegate(object o, ref object v)
					{
						int childAlignment = (int)((GridLayoutGroup)o).childAlignment;
						if (!childAlignment.Equals((int)v))
						{
							v = childAlignment;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "constraint",
					PropertyType = typeof(GridLayoutGroup.Constraint),
					Setter = (object o, object v) =>
					{
						((GridLayoutGroup)o).constraint = (GridLayoutGroup.Constraint)v;
					},
					Getter = (object o) => ((GridLayoutGroup)o).constraint,
					Updater = delegate(object o, ref object v)
					{
						int constraint = (int)((GridLayoutGroup)o).constraint;
						if (!constraint.Equals((int)v))
						{
							v = constraint;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((GridLayoutGroup)o).enabled = (bool)v;
					},
					Getter = (object o) => ((GridLayoutGroup)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((GridLayoutGroup)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.HingeJoint",
			new ProximaComponentCommands.PropertyInfo[18]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).connectedBody = (Rigidbody)v;
					},
					Getter = (object o) => ((HingeJoint)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedArticulationBody",
					PropertyType = typeof(ArticulationBody),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).connectedArticulationBody = (ArticulationBody)v;
					},
					Getter = (object o) => ((HingeJoint)o).connectedArticulationBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).anchor = (Vector3)v;
					},
					Getter = (object o) => ((HingeJoint)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector3 anchor = ((HingeJoint)o).anchor;
						if (!anchor.Equals((Vector3)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "axis",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).axis = (Vector3)v;
					},
					Getter = (object o) => ((HingeJoint)o).axis,
					Updater = delegate(object o, ref object v)
					{
						Vector3 axis = ((HingeJoint)o).axis;
						if (!axis.Equals((Vector3)v))
						{
							v = axis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureConnectedAnchor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).autoConfigureConnectedAnchor = (bool)v;
					},
					Getter = (object o) => ((HingeJoint)o).autoConfigureConnectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureConnectedAnchor = ((HingeJoint)o).autoConfigureConnectedAnchor;
						if (!autoConfigureConnectedAnchor.Equals((bool)v))
						{
							v = autoConfigureConnectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedAnchor",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).connectedAnchor = (Vector3)v;
					},
					Getter = (object o) => ((HingeJoint)o).connectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						Vector3 connectedAnchor = ((HingeJoint)o).connectedAnchor;
						if (!connectedAnchor.Equals((Vector3)v))
						{
							v = connectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useSpring",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).useSpring = (bool)v;
					},
					Getter = (object o) => ((HingeJoint)o).useSpring,
					Updater = delegate(object o, ref object v)
					{
						bool useSpring = ((HingeJoint)o).useSpring;
						if (!useSpring.Equals((bool)v))
						{
							v = useSpring;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spring",
					PropertyType = typeof(JointSpring),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).spring = (JointSpring)v;
					},
					Getter = (object o) => ((HingeJoint)o).spring,
					Updater = delegate(object o, ref object v)
					{
						JointSpring spring = ((HingeJoint)o).spring;
						if (!spring.Equals((JointSpring)v))
						{
							v = spring;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useMotor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).useMotor = (bool)v;
					},
					Getter = (object o) => ((HingeJoint)o).useMotor,
					Updater = delegate(object o, ref object v)
					{
						bool useMotor = ((HingeJoint)o).useMotor;
						if (!useMotor.Equals((bool)v))
						{
							v = useMotor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "motor",
					PropertyType = typeof(JointMotor),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).motor = (JointMotor)v;
					},
					Getter = (object o) => ((HingeJoint)o).motor,
					Updater = delegate(object o, ref object v)
					{
						JointMotor motor = ((HingeJoint)o).motor;
						if (!motor.Equals((JointMotor)v))
						{
							v = motor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useLimits",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).useLimits = (bool)v;
					},
					Getter = (object o) => ((HingeJoint)o).useLimits,
					Updater = delegate(object o, ref object v)
					{
						bool useLimits = ((HingeJoint)o).useLimits;
						if (!useLimits.Equals((bool)v))
						{
							v = useLimits;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "limits",
					PropertyType = typeof(JointLimits),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).limits = (JointLimits)v;
					},
					Getter = (object o) => ((HingeJoint)o).limits,
					Updater = delegate(object o, ref object v)
					{
						JointLimits limits = ((HingeJoint)o).limits;
						if (!limits.Equals((JointLimits)v))
						{
							v = limits;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).breakForce = (float)v;
					},
					Getter = (object o) => ((HingeJoint)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((HingeJoint)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).breakTorque = (float)v;
					},
					Getter = (object o) => ((HingeJoint)o).breakTorque,
					Updater = delegate(object o, ref object v)
					{
						float breakTorque = ((HingeJoint)o).breakTorque;
						if (!breakTorque.Equals((float)v))
						{
							v = breakTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((HingeJoint)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((HingeJoint)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enablePreprocessing",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).enablePreprocessing = (bool)v;
					},
					Getter = (object o) => ((HingeJoint)o).enablePreprocessing,
					Updater = delegate(object o, ref object v)
					{
						bool enablePreprocessing = ((HingeJoint)o).enablePreprocessing;
						if (!enablePreprocessing.Equals((bool)v))
						{
							v = enablePreprocessing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "massScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).massScale = (float)v;
					},
					Getter = (object o) => ((HingeJoint)o).massScale,
					Updater = delegate(object o, ref object v)
					{
						float massScale = ((HingeJoint)o).massScale;
						if (!massScale.Equals((float)v))
						{
							v = massScale;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedMassScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((HingeJoint)o).connectedMassScale = (float)v;
					},
					Getter = (object o) => ((HingeJoint)o).connectedMassScale,
					Updater = delegate(object o, ref object v)
					{
						float connectedMassScale = ((HingeJoint)o).connectedMassScale;
						if (!connectedMassScale.Equals((float)v))
						{
							v = connectedMassScale;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.HingeJoint2D",
			new ProximaComponentCommands.PropertyInfo[12]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((HingeJoint2D)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody2D),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).connectedBody = (Rigidbody2D)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureConnectedAnchor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).autoConfigureConnectedAnchor = (bool)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).autoConfigureConnectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureConnectedAnchor = ((HingeJoint2D)o).autoConfigureConnectedAnchor;
						if (!autoConfigureConnectedAnchor.Equals((bool)v))
						{
							v = autoConfigureConnectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).anchor = (Vector2)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 anchor = ((HingeJoint2D)o).anchor;
						if (!anchor.Equals((Vector2)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedAnchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).connectedAnchor = (Vector2)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).connectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 connectedAnchor = ((HingeJoint2D)o).connectedAnchor;
						if (!connectedAnchor.Equals((Vector2)v))
						{
							v = connectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useMotor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).useMotor = (bool)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).useMotor,
					Updater = delegate(object o, ref object v)
					{
						bool useMotor = ((HingeJoint2D)o).useMotor;
						if (!useMotor.Equals((bool)v))
						{
							v = useMotor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "motor",
					PropertyType = typeof(JointMotor2D),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).motor = (JointMotor2D)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).motor,
					Updater = delegate(object o, ref object v)
					{
						JointMotor2D motor = ((HingeJoint2D)o).motor;
						if (!motor.Equals((JointMotor2D)v))
						{
							v = motor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useLimits",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).useLimits = (bool)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).useLimits,
					Updater = delegate(object o, ref object v)
					{
						bool useLimits = ((HingeJoint2D)o).useLimits;
						if (!useLimits.Equals((bool)v))
						{
							v = useLimits;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "limits",
					PropertyType = typeof(JointAngleLimits2D),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).limits = (JointAngleLimits2D)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).limits,
					Updater = delegate(object o, ref object v)
					{
						JointAngleLimits2D limits = ((HingeJoint2D)o).limits;
						if (!limits.Equals((JointAngleLimits2D)v))
						{
							v = limits;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).breakForce = (float)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((HingeJoint2D)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).breakTorque = (float)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).breakTorque,
					Updater = delegate(object o, ref object v)
					{
						float breakTorque = ((HingeJoint2D)o).breakTorque;
						if (!breakTorque.Equals((float)v))
						{
							v = breakTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HingeJoint2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((HingeJoint2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((HingeJoint2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.HorizontalLayoutGroup",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "padding",
					PropertyType = typeof(RectOffset),
					Setter = (object o, object v) =>
					{
						((HorizontalLayoutGroup)o).padding = (RectOffset)v;
					},
					Getter = (object o) => ((HorizontalLayoutGroup)o).padding
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((HorizontalLayoutGroup)o).spacing = (float)v;
					},
					Getter = (object o) => ((HorizontalLayoutGroup)o).spacing,
					Updater = delegate(object o, ref object v)
					{
						float spacing = ((HorizontalLayoutGroup)o).spacing;
						if (!spacing.Equals((float)v))
						{
							v = spacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childAlignment",
					PropertyType = typeof(TextAnchor),
					Setter = (object o, object v) =>
					{
						((HorizontalLayoutGroup)o).childAlignment = (TextAnchor)v;
					},
					Getter = (object o) => ((HorizontalLayoutGroup)o).childAlignment,
					Updater = delegate(object o, ref object v)
					{
						int childAlignment = (int)((HorizontalLayoutGroup)o).childAlignment;
						if (!childAlignment.Equals((int)v))
						{
							v = childAlignment;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childControlWidth",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HorizontalLayoutGroup)o).childControlWidth = (bool)v;
					},
					Getter = (object o) => ((HorizontalLayoutGroup)o).childControlWidth,
					Updater = delegate(object o, ref object v)
					{
						bool childControlWidth = ((HorizontalLayoutGroup)o).childControlWidth;
						if (!childControlWidth.Equals((bool)v))
						{
							v = childControlWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childControlHeight",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HorizontalLayoutGroup)o).childControlHeight = (bool)v;
					},
					Getter = (object o) => ((HorizontalLayoutGroup)o).childControlHeight,
					Updater = delegate(object o, ref object v)
					{
						bool childControlHeight = ((HorizontalLayoutGroup)o).childControlHeight;
						if (!childControlHeight.Equals((bool)v))
						{
							v = childControlHeight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childScaleWidth",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HorizontalLayoutGroup)o).childScaleWidth = (bool)v;
					},
					Getter = (object o) => ((HorizontalLayoutGroup)o).childScaleWidth,
					Updater = delegate(object o, ref object v)
					{
						bool childScaleWidth = ((HorizontalLayoutGroup)o).childScaleWidth;
						if (!childScaleWidth.Equals((bool)v))
						{
							v = childScaleWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childScaleHeight",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HorizontalLayoutGroup)o).childScaleHeight = (bool)v;
					},
					Getter = (object o) => ((HorizontalLayoutGroup)o).childScaleHeight,
					Updater = delegate(object o, ref object v)
					{
						bool childScaleHeight = ((HorizontalLayoutGroup)o).childScaleHeight;
						if (!childScaleHeight.Equals((bool)v))
						{
							v = childScaleHeight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childForceExpandWidth",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HorizontalLayoutGroup)o).childForceExpandWidth = (bool)v;
					},
					Getter = (object o) => ((HorizontalLayoutGroup)o).childForceExpandWidth,
					Updater = delegate(object o, ref object v)
					{
						bool childForceExpandWidth = ((HorizontalLayoutGroup)o).childForceExpandWidth;
						if (!childForceExpandWidth.Equals((bool)v))
						{
							v = childForceExpandWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childForceExpandHeight",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HorizontalLayoutGroup)o).childForceExpandHeight = (bool)v;
					},
					Getter = (object o) => ((HorizontalLayoutGroup)o).childForceExpandHeight,
					Updater = delegate(object o, ref object v)
					{
						bool childForceExpandHeight = ((HorizontalLayoutGroup)o).childForceExpandHeight;
						if (!childForceExpandHeight.Equals((bool)v))
						{
							v = childForceExpandHeight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((HorizontalLayoutGroup)o).enabled = (bool)v;
					},
					Getter = (object o) => ((HorizontalLayoutGroup)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((HorizontalLayoutGroup)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.VerticalLayoutGroup",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "padding",
					PropertyType = typeof(RectOffset),
					Setter = (object o, object v) =>
					{
						((VerticalLayoutGroup)o).padding = (RectOffset)v;
					},
					Getter = (object o) => ((VerticalLayoutGroup)o).padding
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((VerticalLayoutGroup)o).spacing = (float)v;
					},
					Getter = (object o) => ((VerticalLayoutGroup)o).spacing,
					Updater = delegate(object o, ref object v)
					{
						float spacing = ((VerticalLayoutGroup)o).spacing;
						if (!spacing.Equals((float)v))
						{
							v = spacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childAlignment",
					PropertyType = typeof(TextAnchor),
					Setter = (object o, object v) =>
					{
						((VerticalLayoutGroup)o).childAlignment = (TextAnchor)v;
					},
					Getter = (object o) => ((VerticalLayoutGroup)o).childAlignment,
					Updater = delegate(object o, ref object v)
					{
						int childAlignment = (int)((VerticalLayoutGroup)o).childAlignment;
						if (!childAlignment.Equals((int)v))
						{
							v = childAlignment;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childControlWidth",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VerticalLayoutGroup)o).childControlWidth = (bool)v;
					},
					Getter = (object o) => ((VerticalLayoutGroup)o).childControlWidth,
					Updater = delegate(object o, ref object v)
					{
						bool childControlWidth = ((VerticalLayoutGroup)o).childControlWidth;
						if (!childControlWidth.Equals((bool)v))
						{
							v = childControlWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childControlHeight",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VerticalLayoutGroup)o).childControlHeight = (bool)v;
					},
					Getter = (object o) => ((VerticalLayoutGroup)o).childControlHeight,
					Updater = delegate(object o, ref object v)
					{
						bool childControlHeight = ((VerticalLayoutGroup)o).childControlHeight;
						if (!childControlHeight.Equals((bool)v))
						{
							v = childControlHeight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childScaleWidth",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VerticalLayoutGroup)o).childScaleWidth = (bool)v;
					},
					Getter = (object o) => ((VerticalLayoutGroup)o).childScaleWidth,
					Updater = delegate(object o, ref object v)
					{
						bool childScaleWidth = ((VerticalLayoutGroup)o).childScaleWidth;
						if (!childScaleWidth.Equals((bool)v))
						{
							v = childScaleWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childScaleHeight",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VerticalLayoutGroup)o).childScaleHeight = (bool)v;
					},
					Getter = (object o) => ((VerticalLayoutGroup)o).childScaleHeight,
					Updater = delegate(object o, ref object v)
					{
						bool childScaleHeight = ((VerticalLayoutGroup)o).childScaleHeight;
						if (!childScaleHeight.Equals((bool)v))
						{
							v = childScaleHeight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childForceExpandWidth",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VerticalLayoutGroup)o).childForceExpandWidth = (bool)v;
					},
					Getter = (object o) => ((VerticalLayoutGroup)o).childForceExpandWidth,
					Updater = delegate(object o, ref object v)
					{
						bool childForceExpandWidth = ((VerticalLayoutGroup)o).childForceExpandWidth;
						if (!childForceExpandWidth.Equals((bool)v))
						{
							v = childForceExpandWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "childForceExpandHeight",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VerticalLayoutGroup)o).childForceExpandHeight = (bool)v;
					},
					Getter = (object o) => ((VerticalLayoutGroup)o).childForceExpandHeight,
					Updater = delegate(object o, ref object v)
					{
						bool childForceExpandHeight = ((VerticalLayoutGroup)o).childForceExpandHeight;
						if (!childForceExpandHeight.Equals((bool)v))
						{
							v = childForceExpandHeight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VerticalLayoutGroup)o).enabled = (bool)v;
					},
					Getter = (object o) => ((VerticalLayoutGroup)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((VerticalLayoutGroup)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.Image",
			new ProximaComponentCommands.PropertyInfo[7]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sprite",
					PropertyType = typeof(Sprite),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Image)o).sprite = (Sprite)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Image)o).sprite
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "material",
					PropertyType = typeof(Material),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Image)o).material = (Material)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Image)o).material
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "color",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Image)o).color = (Color)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Image)o).color,
					Updater = delegate(object o, ref object v)
					{
						Color color = ((UnityEngine.UI.Image)o).color;
						if (!color.Equals((Color)v))
						{
							v = color;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "raycastTarget",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Image)o).raycastTarget = (bool)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Image)o).raycastTarget,
					Updater = delegate(object o, ref object v)
					{
						bool raycastTarget = ((UnityEngine.UI.Image)o).raycastTarget;
						if (!raycastTarget.Equals((bool)v))
						{
							v = raycastTarget;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "raycastPadding",
					PropertyType = typeof(Vector4),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Image)o).raycastPadding = (Vector4)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Image)o).raycastPadding,
					Updater = delegate(object o, ref object v)
					{
						Vector4 raycastPadding = ((UnityEngine.UI.Image)o).raycastPadding;
						if (!raycastPadding.Equals((Vector4)v))
						{
							v = raycastPadding;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maskable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Image)o).maskable = (bool)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Image)o).maskable,
					Updater = delegate(object o, ref object v)
					{
						bool maskable = ((UnityEngine.UI.Image)o).maskable;
						if (!maskable.Equals((bool)v))
						{
							v = maskable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Image)o).enabled = (bool)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Image)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((UnityEngine.UI.Image)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.InputField",
			new ProximaComponentCommands.PropertyInfo[19]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "interactable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((InputField)o).interactable = (bool)v;
					},
					Getter = (object o) => ((InputField)o).interactable,
					Updater = delegate(object o, ref object v)
					{
						bool interactable = ((InputField)o).interactable;
						if (!interactable.Equals((bool)v))
						{
							v = interactable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "transition",
					PropertyType = typeof(Selectable.Transition),
					Setter = (object o, object v) =>
					{
						((InputField)o).transition = (Selectable.Transition)v;
					},
					Getter = (object o) => ((InputField)o).transition,
					Updater = delegate(object o, ref object v)
					{
						int transition = (int)((InputField)o).transition;
						if (!transition.Equals((int)v))
						{
							v = transition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetGraphic",
					PropertyType = typeof(Graphic),
					Setter = (object o, object v) =>
					{
						((InputField)o).targetGraphic = (Graphic)v;
					},
					Getter = (object o) => ((InputField)o).targetGraphic
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colors",
					PropertyType = typeof(ColorBlock),
					Setter = (object o, object v) =>
					{
						((InputField)o).colors = (ColorBlock)v;
					},
					Getter = (object o) => ((InputField)o).colors,
					Updater = delegate(object o, ref object v)
					{
						ColorBlock colors = ((InputField)o).colors;
						if (!colors.Equals((ColorBlock)v))
						{
							v = colors;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "navigation",
					PropertyType = typeof(Navigation),
					Setter = (object o, object v) =>
					{
						((InputField)o).navigation = (Navigation)v;
					},
					Getter = (object o) => ((InputField)o).navigation,
					Updater = delegate(object o, ref object v)
					{
						Navigation navigation = ((InputField)o).navigation;
						if (!navigation.Equals((Navigation)v))
						{
							v = navigation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "textComponent",
					PropertyType = typeof(Text),
					Setter = (object o, object v) =>
					{
						((InputField)o).textComponent = (Text)v;
					},
					Getter = (object o) => ((InputField)o).textComponent
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "text",
					PropertyType = typeof(string),
					Setter = (object o, object v) =>
					{
						((InputField)o).text = (string)v;
					},
					Getter = (object o) => ((InputField)o).text
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "characterLimit",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((InputField)o).characterLimit = (int)v;
					},
					Getter = (object o) => ((InputField)o).characterLimit,
					Updater = delegate(object o, ref object v)
					{
						int characterLimit = ((InputField)o).characterLimit;
						if (!characterLimit.Equals((int)v))
						{
							v = characterLimit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "contentType",
					PropertyType = typeof(InputField.ContentType),
					Setter = (object o, object v) =>
					{
						((InputField)o).contentType = (InputField.ContentType)v;
					},
					Getter = (object o) => ((InputField)o).contentType,
					Updater = delegate(object o, ref object v)
					{
						int contentType = (int)((InputField)o).contentType;
						if (!contentType.Equals((int)v))
						{
							v = contentType;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lineType",
					PropertyType = typeof(InputField.LineType),
					Setter = (object o, object v) =>
					{
						((InputField)o).lineType = (InputField.LineType)v;
					},
					Getter = (object o) => ((InputField)o).lineType,
					Updater = delegate(object o, ref object v)
					{
						int lineType = (int)((InputField)o).lineType;
						if (!lineType.Equals((int)v))
						{
							v = lineType;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "placeholder",
					PropertyType = typeof(Graphic),
					Setter = (object o, object v) =>
					{
						((InputField)o).placeholder = (Graphic)v;
					},
					Getter = (object o) => ((InputField)o).placeholder
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "caretBlinkRate",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((InputField)o).caretBlinkRate = (float)v;
					},
					Getter = (object o) => ((InputField)o).caretBlinkRate,
					Updater = delegate(object o, ref object v)
					{
						float caretBlinkRate = ((InputField)o).caretBlinkRate;
						if (!caretBlinkRate.Equals((float)v))
						{
							v = caretBlinkRate;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "caretWidth",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((InputField)o).caretWidth = (int)v;
					},
					Getter = (object o) => ((InputField)o).caretWidth,
					Updater = delegate(object o, ref object v)
					{
						int caretWidth = ((InputField)o).caretWidth;
						if (!caretWidth.Equals((int)v))
						{
							v = caretWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "customCaretColor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((InputField)o).customCaretColor = (bool)v;
					},
					Getter = (object o) => ((InputField)o).customCaretColor,
					Updater = delegate(object o, ref object v)
					{
						bool customCaretColor = ((InputField)o).customCaretColor;
						if (!customCaretColor.Equals((bool)v))
						{
							v = customCaretColor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "selectionColor",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((InputField)o).selectionColor = (Color)v;
					},
					Getter = (object o) => ((InputField)o).selectionColor,
					Updater = delegate(object o, ref object v)
					{
						Color selectionColor = ((InputField)o).selectionColor;
						if (!selectionColor.Equals((Color)v))
						{
							v = selectionColor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shouldHideMobileInput",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((InputField)o).shouldHideMobileInput = (bool)v;
					},
					Getter = (object o) => ((InputField)o).shouldHideMobileInput,
					Updater = delegate(object o, ref object v)
					{
						bool shouldHideMobileInput = ((InputField)o).shouldHideMobileInput;
						if (!shouldHideMobileInput.Equals((bool)v))
						{
							v = shouldHideMobileInput;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "readOnly",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((InputField)o).readOnly = (bool)v;
					},
					Getter = (object o) => ((InputField)o).readOnly,
					Updater = delegate(object o, ref object v)
					{
						bool readOnly = ((InputField)o).readOnly;
						if (!readOnly.Equals((bool)v))
						{
							v = readOnly;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shouldActivateOnSelect",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((InputField)o).shouldActivateOnSelect = (bool)v;
					},
					Getter = (object o) => ((InputField)o).shouldActivateOnSelect,
					Updater = delegate(object o, ref object v)
					{
						bool shouldActivateOnSelect = ((InputField)o).shouldActivateOnSelect;
						if (!shouldActivateOnSelect.Equals((bool)v))
						{
							v = shouldActivateOnSelect;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((InputField)o).enabled = (bool)v;
					},
					Getter = (object o) => ((InputField)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((InputField)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.LayoutElement",
			new ProximaComponentCommands.PropertyInfo[9]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "ignoreLayout",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LayoutElement)o).ignoreLayout = (bool)v;
					},
					Getter = (object o) => ((LayoutElement)o).ignoreLayout,
					Updater = delegate(object o, ref object v)
					{
						bool ignoreLayout = ((LayoutElement)o).ignoreLayout;
						if (!ignoreLayout.Equals((bool)v))
						{
							v = ignoreLayout;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "minWidth",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LayoutElement)o).minWidth = (float)v;
					},
					Getter = (object o) => ((LayoutElement)o).minWidth,
					Updater = delegate(object o, ref object v)
					{
						float minWidth = ((LayoutElement)o).minWidth;
						if (!minWidth.Equals((float)v))
						{
							v = minWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "minHeight",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LayoutElement)o).minHeight = (float)v;
					},
					Getter = (object o) => ((LayoutElement)o).minHeight,
					Updater = delegate(object o, ref object v)
					{
						float minHeight = ((LayoutElement)o).minHeight;
						if (!minHeight.Equals((float)v))
						{
							v = minHeight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "preferredWidth",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LayoutElement)o).preferredWidth = (float)v;
					},
					Getter = (object o) => ((LayoutElement)o).preferredWidth,
					Updater = delegate(object o, ref object v)
					{
						float preferredWidth = ((LayoutElement)o).preferredWidth;
						if (!preferredWidth.Equals((float)v))
						{
							v = preferredWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "preferredHeight",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LayoutElement)o).preferredHeight = (float)v;
					},
					Getter = (object o) => ((LayoutElement)o).preferredHeight,
					Updater = delegate(object o, ref object v)
					{
						float preferredHeight = ((LayoutElement)o).preferredHeight;
						if (!preferredHeight.Equals((float)v))
						{
							v = preferredHeight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "flexibleWidth",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LayoutElement)o).flexibleWidth = (float)v;
					},
					Getter = (object o) => ((LayoutElement)o).flexibleWidth,
					Updater = delegate(object o, ref object v)
					{
						float flexibleWidth = ((LayoutElement)o).flexibleWidth;
						if (!flexibleWidth.Equals((float)v))
						{
							v = flexibleWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "flexibleHeight",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LayoutElement)o).flexibleHeight = (float)v;
					},
					Getter = (object o) => ((LayoutElement)o).flexibleHeight,
					Updater = delegate(object o, ref object v)
					{
						float flexibleHeight = ((LayoutElement)o).flexibleHeight;
						if (!flexibleHeight.Equals((float)v))
						{
							v = flexibleHeight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "layoutPriority",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((LayoutElement)o).layoutPriority = (int)v;
					},
					Getter = (object o) => ((LayoutElement)o).layoutPriority,
					Updater = delegate(object o, ref object v)
					{
						int layoutPriority = ((LayoutElement)o).layoutPriority;
						if (!layoutPriority.Equals((int)v))
						{
							v = layoutPriority;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LayoutElement)o).enabled = (bool)v;
					},
					Getter = (object o) => ((LayoutElement)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((LayoutElement)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.LensFlare",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "flare",
					PropertyType = typeof(Flare),
					Setter = (object o, object v) =>
					{
						((LensFlare)o).flare = (Flare)v;
					},
					Getter = (object o) => ((LensFlare)o).flare
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "color",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((LensFlare)o).color = (Color)v;
					},
					Getter = (object o) => ((LensFlare)o).color,
					Updater = delegate(object o, ref object v)
					{
						Color color = ((LensFlare)o).color;
						if (!color.Equals((Color)v))
						{
							v = color;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "brightness",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LensFlare)o).brightness = (float)v;
					},
					Getter = (object o) => ((LensFlare)o).brightness,
					Updater = delegate(object o, ref object v)
					{
						float brightness = ((LensFlare)o).brightness;
						if (!brightness.Equals((float)v))
						{
							v = brightness;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fadeSpeed",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LensFlare)o).fadeSpeed = (float)v;
					},
					Getter = (object o) => ((LensFlare)o).fadeSpeed,
					Updater = delegate(object o, ref object v)
					{
						float fadeSpeed = ((LensFlare)o).fadeSpeed;
						if (!fadeSpeed.Equals((float)v))
						{
							v = fadeSpeed;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LensFlare)o).enabled = (bool)v;
					},
					Getter = (object o) => ((LensFlare)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((LensFlare)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Light",
			new ProximaComponentCommands.PropertyInfo[12]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "type",
					PropertyType = typeof(LightType),
					Setter = (object o, object v) =>
					{
						((Light)o).type = (LightType)v;
					},
					Getter = (object o) => ((Light)o).type,
					Updater = delegate(object o, ref object v)
					{
						int type = (int)((Light)o).type;
						if (!type.Equals((int)v))
						{
							v = type;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "range",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Light)o).range = (float)v;
					},
					Getter = (object o) => ((Light)o).range,
					Updater = delegate(object o, ref object v)
					{
						float range = ((Light)o).range;
						if (!range.Equals((float)v))
						{
							v = range;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spotAngle",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Light)o).spotAngle = (float)v;
					},
					Getter = (object o) => ((Light)o).spotAngle,
					Updater = delegate(object o, ref object v)
					{
						float spotAngle = ((Light)o).spotAngle;
						if (!spotAngle.Equals((float)v))
						{
							v = spotAngle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "color",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((Light)o).color = (Color)v;
					},
					Getter = (object o) => ((Light)o).color,
					Updater = delegate(object o, ref object v)
					{
						Color color = ((Light)o).color;
						if (!color.Equals((Color)v))
						{
							v = color;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "intensity",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Light)o).intensity = (float)v;
					},
					Getter = (object o) => ((Light)o).intensity,
					Updater = delegate(object o, ref object v)
					{
						float intensity = ((Light)o).intensity;
						if (!intensity.Equals((float)v))
						{
							v = intensity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "bounceIntensity",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Light)o).bounceIntensity = (float)v;
					},
					Getter = (object o) => ((Light)o).bounceIntensity,
					Updater = delegate(object o, ref object v)
					{
						float bounceIntensity = ((Light)o).bounceIntensity;
						if (!bounceIntensity.Equals((float)v))
						{
							v = bounceIntensity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shadows",
					PropertyType = typeof(LightShadows),
					Setter = (object o, object v) =>
					{
						((Light)o).shadows = (LightShadows)v;
					},
					Getter = (object o) => ((Light)o).shadows,
					Updater = delegate(object o, ref object v)
					{
						int shadows = (int)((Light)o).shadows;
						if (!shadows.Equals((int)v))
						{
							v = shadows;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cookie",
					PropertyType = typeof(Texture),
					Setter = (object o, object v) =>
					{
						((Light)o).cookie = (Texture)v;
					},
					Getter = (object o) => ((Light)o).cookie
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "flare",
					PropertyType = typeof(Flare),
					Setter = (object o, object v) =>
					{
						((Light)o).flare = (Flare)v;
					},
					Getter = (object o) => ((Light)o).flare
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "renderMode",
					PropertyType = typeof(LightRenderMode),
					Setter = (object o, object v) =>
					{
						((Light)o).renderMode = (LightRenderMode)v;
					},
					Getter = (object o) => ((Light)o).renderMode,
					Updater = delegate(object o, ref object v)
					{
						int renderMode = (int)((Light)o).renderMode;
						if (!renderMode.Equals((int)v))
						{
							v = renderMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cullingMask",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((Light)o).cullingMask = (int)v;
					},
					Getter = (object o) => ((Light)o).cullingMask,
					Updater = delegate(object o, ref object v)
					{
						int cullingMask = ((Light)o).cullingMask;
						if (!cullingMask.Equals((int)v))
						{
							v = cullingMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Light)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Light)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Light)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.LightProbeProxyVolume",
			new ProximaComponentCommands.PropertyInfo[8]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "refreshMode",
					PropertyType = typeof(LightProbeProxyVolume.RefreshMode),
					Setter = (object o, object v) =>
					{
						((LightProbeProxyVolume)o).refreshMode = (LightProbeProxyVolume.RefreshMode)v;
					},
					Getter = (object o) => ((LightProbeProxyVolume)o).refreshMode,
					Updater = delegate(object o, ref object v)
					{
						int refreshMode = (int)((LightProbeProxyVolume)o).refreshMode;
						if (!refreshMode.Equals((int)v))
						{
							v = refreshMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "qualityMode",
					PropertyType = typeof(LightProbeProxyVolume.QualityMode),
					Setter = (object o, object v) =>
					{
						((LightProbeProxyVolume)o).qualityMode = (LightProbeProxyVolume.QualityMode)v;
					},
					Getter = (object o) => ((LightProbeProxyVolume)o).qualityMode,
					Updater = delegate(object o, ref object v)
					{
						int qualityMode = (int)((LightProbeProxyVolume)o).qualityMode;
						if (!qualityMode.Equals((int)v))
						{
							v = qualityMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "dataFormat",
					PropertyType = typeof(LightProbeProxyVolume.DataFormat),
					Setter = (object o, object v) =>
					{
						((LightProbeProxyVolume)o).dataFormat = (LightProbeProxyVolume.DataFormat)v;
					},
					Getter = (object o) => ((LightProbeProxyVolume)o).dataFormat,
					Updater = delegate(object o, ref object v)
					{
						int dataFormat = (int)((LightProbeProxyVolume)o).dataFormat;
						if (!dataFormat.Equals((int)v))
						{
							v = dataFormat;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "boundingBoxMode",
					PropertyType = typeof(LightProbeProxyVolume.BoundingBoxMode),
					Setter = (object o, object v) =>
					{
						((LightProbeProxyVolume)o).boundingBoxMode = (LightProbeProxyVolume.BoundingBoxMode)v;
					},
					Getter = (object o) => ((LightProbeProxyVolume)o).boundingBoxMode,
					Updater = delegate(object o, ref object v)
					{
						int boundingBoxMode = (int)((LightProbeProxyVolume)o).boundingBoxMode;
						if (!boundingBoxMode.Equals((int)v))
						{
							v = boundingBoxMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "resolutionMode",
					PropertyType = typeof(LightProbeProxyVolume.ResolutionMode),
					Setter = (object o, object v) =>
					{
						((LightProbeProxyVolume)o).resolutionMode = (LightProbeProxyVolume.ResolutionMode)v;
					},
					Getter = (object o) => ((LightProbeProxyVolume)o).resolutionMode,
					Updater = delegate(object o, ref object v)
					{
						int resolutionMode = (int)((LightProbeProxyVolume)o).resolutionMode;
						if (!resolutionMode.Equals((int)v))
						{
							v = resolutionMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "probeDensity",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LightProbeProxyVolume)o).probeDensity = (float)v;
					},
					Getter = (object o) => ((LightProbeProxyVolume)o).probeDensity,
					Updater = delegate(object o, ref object v)
					{
						float probeDensity = ((LightProbeProxyVolume)o).probeDensity;
						if (!probeDensity.Equals((float)v))
						{
							v = probeDensity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "probePositionMode",
					PropertyType = typeof(LightProbeProxyVolume.ProbePositionMode),
					Setter = (object o, object v) =>
					{
						((LightProbeProxyVolume)o).probePositionMode = (LightProbeProxyVolume.ProbePositionMode)v;
					},
					Getter = (object o) => ((LightProbeProxyVolume)o).probePositionMode,
					Updater = delegate(object o, ref object v)
					{
						int probePositionMode = (int)((LightProbeProxyVolume)o).probePositionMode;
						if (!probePositionMode.Equals((int)v))
						{
							v = probePositionMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LightProbeProxyVolume)o).enabled = (bool)v;
					},
					Getter = (object o) => ((LightProbeProxyVolume)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((LightProbeProxyVolume)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.LineRenderer",
			new ProximaComponentCommands.PropertyInfo[20]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "loop",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).loop = (bool)v;
					},
					Getter = (object o) => ((LineRenderer)o).loop,
					Updater = delegate(object o, ref object v)
					{
						bool loop = ((LineRenderer)o).loop;
						if (!loop.Equals((bool)v))
						{
							v = loop;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "startColor",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).startColor = (Color)v;
					},
					Getter = (object o) => ((LineRenderer)o).startColor,
					Updater = delegate(object o, ref object v)
					{
						Color startColor = ((LineRenderer)o).startColor;
						if (!startColor.Equals((Color)v))
						{
							v = startColor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "endColor",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).endColor = (Color)v;
					},
					Getter = (object o) => ((LineRenderer)o).endColor,
					Updater = delegate(object o, ref object v)
					{
						Color endColor = ((LineRenderer)o).endColor;
						if (!endColor.Equals((Color)v))
						{
							v = endColor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "numCornerVertices",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).numCornerVertices = (int)v;
					},
					Getter = (object o) => ((LineRenderer)o).numCornerVertices,
					Updater = delegate(object o, ref object v)
					{
						int numCornerVertices = ((LineRenderer)o).numCornerVertices;
						if (!numCornerVertices.Equals((int)v))
						{
							v = numCornerVertices;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "numCapVertices",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).numCapVertices = (int)v;
					},
					Getter = (object o) => ((LineRenderer)o).numCapVertices,
					Updater = delegate(object o, ref object v)
					{
						int numCapVertices = ((LineRenderer)o).numCapVertices;
						if (!numCapVertices.Equals((int)v))
						{
							v = numCapVertices;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "alignment",
					PropertyType = typeof(LineAlignment),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).alignment = (LineAlignment)v;
					},
					Getter = (object o) => ((LineRenderer)o).alignment,
					Updater = delegate(object o, ref object v)
					{
						int alignment = (int)((LineRenderer)o).alignment;
						if (!alignment.Equals((int)v))
						{
							v = alignment;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "textureMode",
					PropertyType = typeof(LineTextureMode),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).textureMode = (LineTextureMode)v;
					},
					Getter = (object o) => ((LineRenderer)o).textureMode,
					Updater = delegate(object o, ref object v)
					{
						int textureMode = (int)((LineRenderer)o).textureMode;
						if (!textureMode.Equals((int)v))
						{
							v = textureMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shadowBias",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).shadowBias = (float)v;
					},
					Getter = (object o) => ((LineRenderer)o).shadowBias,
					Updater = delegate(object o, ref object v)
					{
						float shadowBias = ((LineRenderer)o).shadowBias;
						if (!shadowBias.Equals((float)v))
						{
							v = shadowBias;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "generateLightingData",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).generateLightingData = (bool)v;
					},
					Getter = (object o) => ((LineRenderer)o).generateLightingData,
					Updater = delegate(object o, ref object v)
					{
						bool generateLightingData = ((LineRenderer)o).generateLightingData;
						if (!generateLightingData.Equals((bool)v))
						{
							v = generateLightingData;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useWorldSpace",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).useWorldSpace = (bool)v;
					},
					Getter = (object o) => ((LineRenderer)o).useWorldSpace,
					Updater = delegate(object o, ref object v)
					{
						bool useWorldSpace = ((LineRenderer)o).useWorldSpace;
						if (!useWorldSpace.Equals((bool)v))
						{
							v = useWorldSpace;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterials",
					PropertyType = typeof(Material[]),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).sharedMaterials = (Material[])v;
					},
					Getter = (object o) => ((LineRenderer)o).sharedMaterials,
					Updater = delegate(object o, ref object v)
					{
						Material[] sharedMaterials = ((LineRenderer)o).sharedMaterials;
						if (sharedMaterials.Length != ((Material[])v).Length)
						{
							v = sharedMaterials;
							return true;
						}
						v = sharedMaterials;
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shadowCastingMode",
					PropertyType = typeof(ShadowCastingMode),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).shadowCastingMode = (ShadowCastingMode)v;
					},
					Getter = (object o) => ((LineRenderer)o).shadowCastingMode,
					Updater = delegate(object o, ref object v)
					{
						int shadowCastingMode = (int)((LineRenderer)o).shadowCastingMode;
						if (!shadowCastingMode.Equals((int)v))
						{
							v = shadowCastingMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "receiveShadows",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).receiveShadows = (bool)v;
					},
					Getter = (object o) => ((LineRenderer)o).receiveShadows,
					Updater = delegate(object o, ref object v)
					{
						bool receiveShadows = ((LineRenderer)o).receiveShadows;
						if (!receiveShadows.Equals((bool)v))
						{
							v = receiveShadows;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lightProbeUsage",
					PropertyType = typeof(LightProbeUsage),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).lightProbeUsage = (LightProbeUsage)v;
					},
					Getter = (object o) => ((LineRenderer)o).lightProbeUsage,
					Updater = delegate(object o, ref object v)
					{
						int lightProbeUsage = (int)((LineRenderer)o).lightProbeUsage;
						if (!lightProbeUsage.Equals((int)v))
						{
							v = lightProbeUsage;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reflectionProbeUsage",
					PropertyType = typeof(ReflectionProbeUsage),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).reflectionProbeUsage = (ReflectionProbeUsage)v;
					},
					Getter = (object o) => ((LineRenderer)o).reflectionProbeUsage,
					Updater = delegate(object o, ref object v)
					{
						int reflectionProbeUsage = (int)((LineRenderer)o).reflectionProbeUsage;
						if (!reflectionProbeUsage.Equals((int)v))
						{
							v = reflectionProbeUsage;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "motionVectorGenerationMode",
					PropertyType = typeof(MotionVectorGenerationMode),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).motionVectorGenerationMode = (MotionVectorGenerationMode)v;
					},
					Getter = (object o) => ((LineRenderer)o).motionVectorGenerationMode,
					Updater = delegate(object o, ref object v)
					{
						int motionVectorGenerationMode = (int)((LineRenderer)o).motionVectorGenerationMode;
						if (!motionVectorGenerationMode.Equals((int)v))
						{
							v = motionVectorGenerationMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "allowOcclusionWhenDynamic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).allowOcclusionWhenDynamic = (bool)v;
					},
					Getter = (object o) => ((LineRenderer)o).allowOcclusionWhenDynamic,
					Updater = delegate(object o, ref object v)
					{
						bool allowOcclusionWhenDynamic = ((LineRenderer)o).allowOcclusionWhenDynamic;
						if (!allowOcclusionWhenDynamic.Equals((bool)v))
						{
							v = allowOcclusionWhenDynamic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingLayerID",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).sortingLayerID = (int)v;
					},
					Getter = (object o) => ((LineRenderer)o).sortingLayerID,
					Updater = delegate(object o, ref object v)
					{
						int sortingLayerID = ((LineRenderer)o).sortingLayerID;
						if (!sortingLayerID.Equals((int)v))
						{
							v = sortingLayerID;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingOrder",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).sortingOrder = (int)v;
					},
					Getter = (object o) => ((LineRenderer)o).sortingOrder,
					Updater = delegate(object o, ref object v)
					{
						int sortingOrder = ((LineRenderer)o).sortingOrder;
						if (!sortingOrder.Equals((int)v))
						{
							v = sortingOrder;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LineRenderer)o).enabled = (bool)v;
					},
					Getter = (object o) => ((LineRenderer)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((LineRenderer)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Animations.LookAtConstraint",
			new ProximaComponentCommands.PropertyInfo[9]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "constraintActive",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LookAtConstraint)o).constraintActive = (bool)v;
					},
					Getter = (object o) => ((LookAtConstraint)o).constraintActive,
					Updater = delegate(object o, ref object v)
					{
						bool constraintActive = ((LookAtConstraint)o).constraintActive;
						if (!constraintActive.Equals((bool)v))
						{
							v = constraintActive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "weight",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LookAtConstraint)o).weight = (float)v;
					},
					Getter = (object o) => ((LookAtConstraint)o).weight,
					Updater = delegate(object o, ref object v)
					{
						float weight = ((LookAtConstraint)o).weight;
						if (!weight.Equals((float)v))
						{
							v = weight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useUpObject",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LookAtConstraint)o).useUpObject = (bool)v;
					},
					Getter = (object o) => ((LookAtConstraint)o).useUpObject,
					Updater = delegate(object o, ref object v)
					{
						bool useUpObject = ((LookAtConstraint)o).useUpObject;
						if (!useUpObject.Equals((bool)v))
						{
							v = useUpObject;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "roll",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((LookAtConstraint)o).roll = (float)v;
					},
					Getter = (object o) => ((LookAtConstraint)o).roll,
					Updater = delegate(object o, ref object v)
					{
						float roll = ((LookAtConstraint)o).roll;
						if (!roll.Equals((float)v))
						{
							v = roll;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "worldUpObject",
					PropertyType = typeof(Transform),
					Setter = (object o, object v) =>
					{
						((LookAtConstraint)o).worldUpObject = (Transform)v;
					},
					Getter = (object o) => ((LookAtConstraint)o).worldUpObject
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "locked",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LookAtConstraint)o).locked = (bool)v;
					},
					Getter = (object o) => ((LookAtConstraint)o).locked,
					Updater = delegate(object o, ref object v)
					{
						bool locked = ((LookAtConstraint)o).locked;
						if (!locked.Equals((bool)v))
						{
							v = locked;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationAtRest",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((LookAtConstraint)o).rotationAtRest = (Vector3)v;
					},
					Getter = (object o) => ((LookAtConstraint)o).rotationAtRest,
					Updater = delegate(object o, ref object v)
					{
						Vector3 rotationAtRest = ((LookAtConstraint)o).rotationAtRest;
						if (!rotationAtRest.Equals((Vector3)v))
						{
							v = rotationAtRest;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationOffset",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((LookAtConstraint)o).rotationOffset = (Vector3)v;
					},
					Getter = (object o) => ((LookAtConstraint)o).rotationOffset,
					Updater = delegate(object o, ref object v)
					{
						Vector3 rotationOffset = ((LookAtConstraint)o).rotationOffset;
						if (!rotationOffset.Equals((Vector3)v))
						{
							v = rotationOffset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((LookAtConstraint)o).enabled = (bool)v;
					},
					Getter = (object o) => ((LookAtConstraint)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((LookAtConstraint)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.Mask",
			new ProximaComponentCommands.PropertyInfo[2]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "showMaskGraphic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Mask)o).showMaskGraphic = (bool)v;
					},
					Getter = (object o) => ((Mask)o).showMaskGraphic,
					Updater = delegate(object o, ref object v)
					{
						bool showMaskGraphic = ((Mask)o).showMaskGraphic;
						if (!showMaskGraphic.Equals((bool)v))
						{
							v = showMaskGraphic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Mask)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Mask)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Mask)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.MeshCollider",
			new ProximaComponentCommands.PropertyInfo[6]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "convex",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((MeshCollider)o).convex = (bool)v;
					},
					Getter = (object o) => ((MeshCollider)o).convex,
					Updater = delegate(object o, ref object v)
					{
						bool convex = ((MeshCollider)o).convex;
						if (!convex.Equals((bool)v))
						{
							v = convex;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTrigger",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((MeshCollider)o).isTrigger = (bool)v;
					},
					Getter = (object o) => ((MeshCollider)o).isTrigger,
					Updater = delegate(object o, ref object v)
					{
						bool isTrigger = ((MeshCollider)o).isTrigger;
						if (!isTrigger.Equals((bool)v))
						{
							v = isTrigger;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cookingOptions",
					PropertyType = typeof(MeshColliderCookingOptions),
					Setter = (object o, object v) =>
					{
						((MeshCollider)o).cookingOptions = (MeshColliderCookingOptions)v;
					},
					Getter = (object o) => ((MeshCollider)o).cookingOptions,
					Updater = delegate(object o, ref object v)
					{
						int cookingOptions = (int)((MeshCollider)o).cookingOptions;
						if (!cookingOptions.Equals((int)v))
						{
							v = cookingOptions;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterial",
					PropertyType = typeof(PhysicMaterial),
					Setter = (object o, object v) =>
					{
						((MeshCollider)o).sharedMaterial = (PhysicMaterial)v;
					},
					Getter = (object o) => ((MeshCollider)o).sharedMaterial
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMesh",
					PropertyType = typeof(Mesh),
					Setter = (object o, object v) =>
					{
						((MeshCollider)o).sharedMesh = (Mesh)v;
					},
					Getter = (object o) => ((MeshCollider)o).sharedMesh
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((MeshCollider)o).enabled = (bool)v;
					},
					Getter = (object o) => ((MeshCollider)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((MeshCollider)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.MeshFilter",
			new ProximaComponentCommands.PropertyInfo[1]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMesh",
					PropertyType = typeof(Mesh),
					Setter = (object o, object v) =>
					{
						((MeshFilter)o).sharedMesh = (Mesh)v;
					},
					Getter = (object o) => ((MeshFilter)o).sharedMesh
				}
			}
		},
		{
			"UnityEngine.MeshRenderer",
			new ProximaComponentCommands.PropertyInfo[9]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterials",
					PropertyType = typeof(Material[]),
					Setter = (object o, object v) =>
					{
						((MeshRenderer)o).sharedMaterials = (Material[])v;
					},
					Getter = (object o) => ((MeshRenderer)o).sharedMaterials,
					Updater = delegate(object o, ref object v)
					{
						Material[] sharedMaterials = ((MeshRenderer)o).sharedMaterials;
						if (sharedMaterials.Length != ((Material[])v).Length)
						{
							v = sharedMaterials;
							return true;
						}
						v = sharedMaterials;
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shadowCastingMode",
					PropertyType = typeof(ShadowCastingMode),
					Setter = (object o, object v) =>
					{
						((MeshRenderer)o).shadowCastingMode = (ShadowCastingMode)v;
					},
					Getter = (object o) => ((MeshRenderer)o).shadowCastingMode,
					Updater = delegate(object o, ref object v)
					{
						int shadowCastingMode = (int)((MeshRenderer)o).shadowCastingMode;
						if (!shadowCastingMode.Equals((int)v))
						{
							v = shadowCastingMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "receiveShadows",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((MeshRenderer)o).receiveShadows = (bool)v;
					},
					Getter = (object o) => ((MeshRenderer)o).receiveShadows,
					Updater = delegate(object o, ref object v)
					{
						bool receiveShadows = ((MeshRenderer)o).receiveShadows;
						if (!receiveShadows.Equals((bool)v))
						{
							v = receiveShadows;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lightProbeUsage",
					PropertyType = typeof(LightProbeUsage),
					Setter = (object o, object v) =>
					{
						((MeshRenderer)o).lightProbeUsage = (LightProbeUsage)v;
					},
					Getter = (object o) => ((MeshRenderer)o).lightProbeUsage,
					Updater = delegate(object o, ref object v)
					{
						int lightProbeUsage = (int)((MeshRenderer)o).lightProbeUsage;
						if (!lightProbeUsage.Equals((int)v))
						{
							v = lightProbeUsage;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reflectionProbeUsage",
					PropertyType = typeof(ReflectionProbeUsage),
					Setter = (object o, object v) =>
					{
						((MeshRenderer)o).reflectionProbeUsage = (ReflectionProbeUsage)v;
					},
					Getter = (object o) => ((MeshRenderer)o).reflectionProbeUsage,
					Updater = delegate(object o, ref object v)
					{
						int reflectionProbeUsage = (int)((MeshRenderer)o).reflectionProbeUsage;
						if (!reflectionProbeUsage.Equals((int)v))
						{
							v = reflectionProbeUsage;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "probeAnchor",
					PropertyType = typeof(Transform),
					Setter = (object o, object v) =>
					{
						((MeshRenderer)o).probeAnchor = (Transform)v;
					},
					Getter = (object o) => ((MeshRenderer)o).probeAnchor
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "motionVectorGenerationMode",
					PropertyType = typeof(MotionVectorGenerationMode),
					Setter = (object o, object v) =>
					{
						((MeshRenderer)o).motionVectorGenerationMode = (MotionVectorGenerationMode)v;
					},
					Getter = (object o) => ((MeshRenderer)o).motionVectorGenerationMode,
					Updater = delegate(object o, ref object v)
					{
						int motionVectorGenerationMode = (int)((MeshRenderer)o).motionVectorGenerationMode;
						if (!motionVectorGenerationMode.Equals((int)v))
						{
							v = motionVectorGenerationMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "allowOcclusionWhenDynamic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((MeshRenderer)o).allowOcclusionWhenDynamic = (bool)v;
					},
					Getter = (object o) => ((MeshRenderer)o).allowOcclusionWhenDynamic,
					Updater = delegate(object o, ref object v)
					{
						bool allowOcclusionWhenDynamic = ((MeshRenderer)o).allowOcclusionWhenDynamic;
						if (!allowOcclusionWhenDynamic.Equals((bool)v))
						{
							v = allowOcclusionWhenDynamic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((MeshRenderer)o).enabled = (bool)v;
					},
					Getter = (object o) => ((MeshRenderer)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((MeshRenderer)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AI.NavMeshAgent",
			new ProximaComponentCommands.PropertyInfo[15]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "agentTypeID",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).agentTypeID = (int)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).agentTypeID,
					Updater = delegate(object o, ref object v)
					{
						int agentTypeID = ((NavMeshAgent)o).agentTypeID;
						if (!agentTypeID.Equals((int)v))
						{
							v = agentTypeID;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "baseOffset",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).baseOffset = (float)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).baseOffset,
					Updater = delegate(object o, ref object v)
					{
						float baseOffset = ((NavMeshAgent)o).baseOffset;
						if (!baseOffset.Equals((float)v))
						{
							v = baseOffset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "speed",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).speed = (float)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).speed,
					Updater = delegate(object o, ref object v)
					{
						float speed = ((NavMeshAgent)o).speed;
						if (!speed.Equals((float)v))
						{
							v = speed;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularSpeed",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).angularSpeed = (float)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).angularSpeed,
					Updater = delegate(object o, ref object v)
					{
						float angularSpeed = ((NavMeshAgent)o).angularSpeed;
						if (!angularSpeed.Equals((float)v))
						{
							v = angularSpeed;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "acceleration",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).acceleration = (float)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).acceleration,
					Updater = delegate(object o, ref object v)
					{
						float acceleration = ((NavMeshAgent)o).acceleration;
						if (!acceleration.Equals((float)v))
						{
							v = acceleration;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "stoppingDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).stoppingDistance = (float)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).stoppingDistance,
					Updater = delegate(object o, ref object v)
					{
						float stoppingDistance = ((NavMeshAgent)o).stoppingDistance;
						if (!stoppingDistance.Equals((float)v))
						{
							v = stoppingDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoBraking",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).autoBraking = (bool)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).autoBraking,
					Updater = delegate(object o, ref object v)
					{
						bool autoBraking = ((NavMeshAgent)o).autoBraking;
						if (!autoBraking.Equals((bool)v))
						{
							v = autoBraking;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "radius",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).radius = (float)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).radius,
					Updater = delegate(object o, ref object v)
					{
						float radius = ((NavMeshAgent)o).radius;
						if (!radius.Equals((float)v))
						{
							v = radius;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "height",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).height = (float)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).height,
					Updater = delegate(object o, ref object v)
					{
						float height = ((NavMeshAgent)o).height;
						if (!height.Equals((float)v))
						{
							v = height;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "obstacleAvoidanceType",
					PropertyType = typeof(ObstacleAvoidanceType),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).obstacleAvoidanceType = (ObstacleAvoidanceType)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).obstacleAvoidanceType,
					Updater = delegate(object o, ref object v)
					{
						int obstacleAvoidanceType = (int)((NavMeshAgent)o).obstacleAvoidanceType;
						if (!obstacleAvoidanceType.Equals((int)v))
						{
							v = obstacleAvoidanceType;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "avoidancePriority",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).avoidancePriority = (int)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).avoidancePriority,
					Updater = delegate(object o, ref object v)
					{
						int avoidancePriority = ((NavMeshAgent)o).avoidancePriority;
						if (!avoidancePriority.Equals((int)v))
						{
							v = avoidancePriority;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoTraverseOffMeshLink",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).autoTraverseOffMeshLink = (bool)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).autoTraverseOffMeshLink,
					Updater = delegate(object o, ref object v)
					{
						bool autoTraverseOffMeshLink = ((NavMeshAgent)o).autoTraverseOffMeshLink;
						if (!autoTraverseOffMeshLink.Equals((bool)v))
						{
							v = autoTraverseOffMeshLink;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoRepath",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).autoRepath = (bool)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).autoRepath,
					Updater = delegate(object o, ref object v)
					{
						bool autoRepath = ((NavMeshAgent)o).autoRepath;
						if (!autoRepath.Equals((bool)v))
						{
							v = autoRepath;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "areaMask",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).areaMask = (int)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).areaMask,
					Updater = delegate(object o, ref object v)
					{
						int areaMask = ((NavMeshAgent)o).areaMask;
						if (!areaMask.Equals((int)v))
						{
							v = areaMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((NavMeshAgent)o).enabled = (bool)v;
					},
					Getter = (object o) => ((NavMeshAgent)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((NavMeshAgent)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AI.NavMeshObstacle",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shape",
					PropertyType = typeof(NavMeshObstacleShape),
					Setter = (object o, object v) =>
					{
						((NavMeshObstacle)o).shape = (NavMeshObstacleShape)v;
					},
					Getter = (object o) => ((NavMeshObstacle)o).shape,
					Updater = delegate(object o, ref object v)
					{
						int shape = (int)((NavMeshObstacle)o).shape;
						if (!shape.Equals((int)v))
						{
							v = shape;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "center",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((NavMeshObstacle)o).center = (Vector3)v;
					},
					Getter = (object o) => ((NavMeshObstacle)o).center,
					Updater = delegate(object o, ref object v)
					{
						Vector3 center = ((NavMeshObstacle)o).center;
						if (!center.Equals((Vector3)v))
						{
							v = center;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "size",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((NavMeshObstacle)o).size = (Vector3)v;
					},
					Getter = (object o) => ((NavMeshObstacle)o).size,
					Updater = delegate(object o, ref object v)
					{
						Vector3 size = ((NavMeshObstacle)o).size;
						if (!size.Equals((Vector3)v))
						{
							v = size;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "carving",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((NavMeshObstacle)o).carving = (bool)v;
					},
					Getter = (object o) => ((NavMeshObstacle)o).carving,
					Updater = delegate(object o, ref object v)
					{
						bool carving = ((NavMeshObstacle)o).carving;
						if (!carving.Equals((bool)v))
						{
							v = carving;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((NavMeshObstacle)o).enabled = (bool)v;
					},
					Getter = (object o) => ((NavMeshObstacle)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((NavMeshObstacle)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.OcclusionArea",
			new ProximaComponentCommands.PropertyInfo[2]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "size",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((OcclusionArea)o).size = (Vector3)v;
					},
					Getter = (object o) => ((OcclusionArea)o).size,
					Updater = delegate(object o, ref object v)
					{
						Vector3 size = ((OcclusionArea)o).size;
						if (!size.Equals((Vector3)v))
						{
							v = size;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "center",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((OcclusionArea)o).center = (Vector3)v;
					},
					Getter = (object o) => ((OcclusionArea)o).center,
					Updater = delegate(object o, ref object v)
					{
						Vector3 center = ((OcclusionArea)o).center;
						if (!center.Equals((Vector3)v))
						{
							v = center;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.OcclusionPortal",
			new ProximaComponentCommands.PropertyInfo[1]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "open",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((OcclusionPortal)o).open = (bool)v;
					},
					Getter = (object o) => ((OcclusionPortal)o).open,
					Updater = delegate(object o, ref object v)
					{
						bool open = ((OcclusionPortal)o).open;
						if (!open.Equals((bool)v))
						{
							v = open;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.AI.OffMeshLink",
			new ProximaComponentCommands.PropertyInfo[8]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "startTransform",
					PropertyType = typeof(Transform),
					Setter = (object o, object v) =>
					{
						((OffMeshLink)o).startTransform = (Transform)v;
					},
					Getter = (object o) => ((OffMeshLink)o).startTransform
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "endTransform",
					PropertyType = typeof(Transform),
					Setter = (object o, object v) =>
					{
						((OffMeshLink)o).endTransform = (Transform)v;
					},
					Getter = (object o) => ((OffMeshLink)o).endTransform
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "costOverride",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((OffMeshLink)o).costOverride = (float)v;
					},
					Getter = (object o) => ((OffMeshLink)o).costOverride,
					Updater = delegate(object o, ref object v)
					{
						float costOverride = ((OffMeshLink)o).costOverride;
						if (!costOverride.Equals((float)v))
						{
							v = costOverride;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "biDirectional",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((OffMeshLink)o).biDirectional = (bool)v;
					},
					Getter = (object o) => ((OffMeshLink)o).biDirectional,
					Updater = delegate(object o, ref object v)
					{
						bool biDirectional = ((OffMeshLink)o).biDirectional;
						if (!biDirectional.Equals((bool)v))
						{
							v = biDirectional;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "activated",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((OffMeshLink)o).activated = (bool)v;
					},
					Getter = (object o) => ((OffMeshLink)o).activated,
					Updater = delegate(object o, ref object v)
					{
						bool activated = ((OffMeshLink)o).activated;
						if (!activated.Equals((bool)v))
						{
							v = activated;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoUpdatePositions",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((OffMeshLink)o).autoUpdatePositions = (bool)v;
					},
					Getter = (object o) => ((OffMeshLink)o).autoUpdatePositions,
					Updater = delegate(object o, ref object v)
					{
						bool autoUpdatePositions = ((OffMeshLink)o).autoUpdatePositions;
						if (!autoUpdatePositions.Equals((bool)v))
						{
							v = autoUpdatePositions;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "area",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((OffMeshLink)o).area = (int)v;
					},
					Getter = (object o) => ((OffMeshLink)o).area,
					Updater = delegate(object o, ref object v)
					{
						int area = ((OffMeshLink)o).area;
						if (!area.Equals((int)v))
						{
							v = area;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((OffMeshLink)o).enabled = (bool)v;
					},
					Getter = (object o) => ((OffMeshLink)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((OffMeshLink)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.Outline",
			new ProximaComponentCommands.PropertyInfo[4]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "effectColor",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((Outline)o).effectColor = (Color)v;
					},
					Getter = (object o) => ((Outline)o).effectColor,
					Updater = delegate(object o, ref object v)
					{
						Color effectColor = ((Outline)o).effectColor;
						if (!effectColor.Equals((Color)v))
						{
							v = effectColor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "effectDistance",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((Outline)o).effectDistance = (Vector2)v;
					},
					Getter = (object o) => ((Outline)o).effectDistance,
					Updater = delegate(object o, ref object v)
					{
						Vector2 effectDistance = ((Outline)o).effectDistance;
						if (!effectDistance.Equals((Vector2)v))
						{
							v = effectDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useGraphicAlpha",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Outline)o).useGraphicAlpha = (bool)v;
					},
					Getter = (object o) => ((Outline)o).useGraphicAlpha,
					Updater = delegate(object o, ref object v)
					{
						bool useGraphicAlpha = ((Outline)o).useGraphicAlpha;
						if (!useGraphicAlpha.Equals((bool)v))
						{
							v = useGraphicAlpha;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Outline)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Outline)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Outline)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Animations.ParentConstraint",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "constraintActive",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ParentConstraint)o).constraintActive = (bool)v;
					},
					Getter = (object o) => ((ParentConstraint)o).constraintActive,
					Updater = delegate(object o, ref object v)
					{
						bool constraintActive = ((ParentConstraint)o).constraintActive;
						if (!constraintActive.Equals((bool)v))
						{
							v = constraintActive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "weight",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ParentConstraint)o).weight = (float)v;
					},
					Getter = (object o) => ((ParentConstraint)o).weight,
					Updater = delegate(object o, ref object v)
					{
						float weight = ((ParentConstraint)o).weight;
						if (!weight.Equals((float)v))
						{
							v = weight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "locked",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ParentConstraint)o).locked = (bool)v;
					},
					Getter = (object o) => ((ParentConstraint)o).locked,
					Updater = delegate(object o, ref object v)
					{
						bool locked = ((ParentConstraint)o).locked;
						if (!locked.Equals((bool)v))
						{
							v = locked;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "translationAtRest",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ParentConstraint)o).translationAtRest = (Vector3)v;
					},
					Getter = (object o) => ((ParentConstraint)o).translationAtRest,
					Updater = delegate(object o, ref object v)
					{
						Vector3 translationAtRest = ((ParentConstraint)o).translationAtRest;
						if (!translationAtRest.Equals((Vector3)v))
						{
							v = translationAtRest;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationAtRest",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ParentConstraint)o).rotationAtRest = (Vector3)v;
					},
					Getter = (object o) => ((ParentConstraint)o).rotationAtRest,
					Updater = delegate(object o, ref object v)
					{
						Vector3 rotationAtRest = ((ParentConstraint)o).rotationAtRest;
						if (!rotationAtRest.Equals((Vector3)v))
						{
							v = rotationAtRest;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "translationOffsets",
					PropertyType = typeof(Vector3[]),
					Setter = (object o, object v) =>
					{
						((ParentConstraint)o).translationOffsets = (Vector3[])v;
					},
					Getter = (object o) => ((ParentConstraint)o).translationOffsets
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationOffsets",
					PropertyType = typeof(Vector3[]),
					Setter = (object o, object v) =>
					{
						((ParentConstraint)o).rotationOffsets = (Vector3[])v;
					},
					Getter = (object o) => ((ParentConstraint)o).rotationOffsets
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "translationAxis",
					PropertyType = typeof(Axis),
					Setter = (object o, object v) =>
					{
						((ParentConstraint)o).translationAxis = (Axis)v;
					},
					Getter = (object o) => ((ParentConstraint)o).translationAxis,
					Updater = delegate(object o, ref object v)
					{
						int translationAxis = (int)((ParentConstraint)o).translationAxis;
						if (!translationAxis.Equals((int)v))
						{
							v = translationAxis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationAxis",
					PropertyType = typeof(Axis),
					Setter = (object o, object v) =>
					{
						((ParentConstraint)o).rotationAxis = (Axis)v;
					},
					Getter = (object o) => ((ParentConstraint)o).rotationAxis,
					Updater = delegate(object o, ref object v)
					{
						int rotationAxis = (int)((ParentConstraint)o).rotationAxis;
						if (!rotationAxis.Equals((int)v))
						{
							v = rotationAxis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ParentConstraint)o).enabled = (bool)v;
					},
					Getter = (object o) => ((ParentConstraint)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((ParentConstraint)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.ParticleSystemForceField",
			new ProximaComponentCommands.PropertyInfo[18]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shape",
					PropertyType = typeof(ParticleSystemForceFieldShape),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).shape = (ParticleSystemForceFieldShape)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).shape,
					Updater = delegate(object o, ref object v)
					{
						int shape = (int)((ParticleSystemForceField)o).shape;
						if (!shape.Equals((int)v))
						{
							v = shape;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "startRange",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).startRange = (float)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).startRange,
					Updater = delegate(object o, ref object v)
					{
						float startRange = ((ParticleSystemForceField)o).startRange;
						if (!startRange.Equals((float)v))
						{
							v = startRange;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "endRange",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).endRange = (float)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).endRange,
					Updater = delegate(object o, ref object v)
					{
						float endRange = ((ParticleSystemForceField)o).endRange;
						if (!endRange.Equals((float)v))
						{
							v = endRange;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "directionX",
					PropertyType = typeof(ParticleSystem.MinMaxCurve),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).directionX = (ParticleSystem.MinMaxCurve)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).directionX,
					Updater = delegate(object o, ref object v)
					{
						ParticleSystem.MinMaxCurve directionX = ((ParticleSystemForceField)o).directionX;
						if (!directionX.Equals((ParticleSystem.MinMaxCurve)v))
						{
							v = directionX;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "directionY",
					PropertyType = typeof(ParticleSystem.MinMaxCurve),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).directionY = (ParticleSystem.MinMaxCurve)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).directionY,
					Updater = delegate(object o, ref object v)
					{
						ParticleSystem.MinMaxCurve directionY = ((ParticleSystemForceField)o).directionY;
						if (!directionY.Equals((ParticleSystem.MinMaxCurve)v))
						{
							v = directionY;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "directionZ",
					PropertyType = typeof(ParticleSystem.MinMaxCurve),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).directionZ = (ParticleSystem.MinMaxCurve)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).directionZ,
					Updater = delegate(object o, ref object v)
					{
						ParticleSystem.MinMaxCurve directionZ = ((ParticleSystemForceField)o).directionZ;
						if (!directionZ.Equals((ParticleSystem.MinMaxCurve)v))
						{
							v = directionZ;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "gravity",
					PropertyType = typeof(ParticleSystem.MinMaxCurve),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).gravity = (ParticleSystem.MinMaxCurve)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).gravity,
					Updater = delegate(object o, ref object v)
					{
						ParticleSystem.MinMaxCurve gravity = ((ParticleSystemForceField)o).gravity;
						if (!gravity.Equals((ParticleSystem.MinMaxCurve)v))
						{
							v = gravity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "gravityFocus",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).gravityFocus = (float)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).gravityFocus,
					Updater = delegate(object o, ref object v)
					{
						float gravityFocus = ((ParticleSystemForceField)o).gravityFocus;
						if (!gravityFocus.Equals((float)v))
						{
							v = gravityFocus;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationSpeed",
					PropertyType = typeof(ParticleSystem.MinMaxCurve),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).rotationSpeed = (ParticleSystem.MinMaxCurve)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).rotationSpeed,
					Updater = delegate(object o, ref object v)
					{
						ParticleSystem.MinMaxCurve rotationSpeed = ((ParticleSystemForceField)o).rotationSpeed;
						if (!rotationSpeed.Equals((ParticleSystem.MinMaxCurve)v))
						{
							v = rotationSpeed;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationAttraction",
					PropertyType = typeof(ParticleSystem.MinMaxCurve),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).rotationAttraction = (ParticleSystem.MinMaxCurve)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).rotationAttraction,
					Updater = delegate(object o, ref object v)
					{
						ParticleSystem.MinMaxCurve rotationAttraction = ((ParticleSystemForceField)o).rotationAttraction;
						if (!rotationAttraction.Equals((ParticleSystem.MinMaxCurve)v))
						{
							v = rotationAttraction;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationRandomness",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).rotationRandomness = (Vector2)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).rotationRandomness,
					Updater = delegate(object o, ref object v)
					{
						Vector2 rotationRandomness = ((ParticleSystemForceField)o).rotationRandomness;
						if (!rotationRandomness.Equals((Vector2)v))
						{
							v = rotationRandomness;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "drag",
					PropertyType = typeof(ParticleSystem.MinMaxCurve),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).drag = (ParticleSystem.MinMaxCurve)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).drag,
					Updater = delegate(object o, ref object v)
					{
						ParticleSystem.MinMaxCurve drag = ((ParticleSystemForceField)o).drag;
						if (!drag.Equals((ParticleSystem.MinMaxCurve)v))
						{
							v = drag;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "multiplyDragByParticleSize",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).multiplyDragByParticleSize = (bool)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).multiplyDragByParticleSize,
					Updater = delegate(object o, ref object v)
					{
						bool multiplyDragByParticleSize = ((ParticleSystemForceField)o).multiplyDragByParticleSize;
						if (!multiplyDragByParticleSize.Equals((bool)v))
						{
							v = multiplyDragByParticleSize;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "multiplyDragByParticleVelocity",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).multiplyDragByParticleVelocity = (bool)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).multiplyDragByParticleVelocity,
					Updater = delegate(object o, ref object v)
					{
						bool multiplyDragByParticleVelocity = ((ParticleSystemForceField)o).multiplyDragByParticleVelocity;
						if (!multiplyDragByParticleVelocity.Equals((bool)v))
						{
							v = multiplyDragByParticleVelocity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "vectorField",
					PropertyType = typeof(Texture3D),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).vectorField = (Texture3D)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).vectorField
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "vectorFieldSpeed",
					PropertyType = typeof(ParticleSystem.MinMaxCurve),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).vectorFieldSpeed = (ParticleSystem.MinMaxCurve)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).vectorFieldSpeed,
					Updater = delegate(object o, ref object v)
					{
						ParticleSystem.MinMaxCurve vectorFieldSpeed = ((ParticleSystemForceField)o).vectorFieldSpeed;
						if (!vectorFieldSpeed.Equals((ParticleSystem.MinMaxCurve)v))
						{
							v = vectorFieldSpeed;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "vectorFieldAttraction",
					PropertyType = typeof(ParticleSystem.MinMaxCurve),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).vectorFieldAttraction = (ParticleSystem.MinMaxCurve)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).vectorFieldAttraction,
					Updater = delegate(object o, ref object v)
					{
						ParticleSystem.MinMaxCurve vectorFieldAttraction = ((ParticleSystemForceField)o).vectorFieldAttraction;
						if (!vectorFieldAttraction.Equals((ParticleSystem.MinMaxCurve)v))
						{
							v = vectorFieldAttraction;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ParticleSystemForceField)o).enabled = (bool)v;
					},
					Getter = (object o) => ((ParticleSystemForceField)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((ParticleSystemForceField)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.EventSystems.Physics2DRaycaster",
			new ProximaComponentCommands.PropertyInfo[3]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "eventMask",
					PropertyType = typeof(LayerMask),
					Setter = (object o, object v) =>
					{
						((Physics2DRaycaster)o).eventMask = (LayerMask)v;
					},
					Getter = (object o) => ((Physics2DRaycaster)o).eventMask,
					Updater = delegate(object o, ref object v)
					{
						LayerMask eventMask = ((Physics2DRaycaster)o).eventMask;
						if (!eventMask.Equals((LayerMask)v))
						{
							v = eventMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxRayIntersections",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((Physics2DRaycaster)o).maxRayIntersections = (int)v;
					},
					Getter = (object o) => ((Physics2DRaycaster)o).maxRayIntersections,
					Updater = delegate(object o, ref object v)
					{
						int maxRayIntersections = ((Physics2DRaycaster)o).maxRayIntersections;
						if (!maxRayIntersections.Equals((int)v))
						{
							v = maxRayIntersections;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Physics2DRaycaster)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Physics2DRaycaster)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Physics2DRaycaster)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.EventSystems.PhysicsRaycaster",
			new ProximaComponentCommands.PropertyInfo[3]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "eventMask",
					PropertyType = typeof(LayerMask),
					Setter = (object o, object v) =>
					{
						((PhysicsRaycaster)o).eventMask = (LayerMask)v;
					},
					Getter = (object o) => ((PhysicsRaycaster)o).eventMask,
					Updater = delegate(object o, ref object v)
					{
						LayerMask eventMask = ((PhysicsRaycaster)o).eventMask;
						if (!eventMask.Equals((LayerMask)v))
						{
							v = eventMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxRayIntersections",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((PhysicsRaycaster)o).maxRayIntersections = (int)v;
					},
					Getter = (object o) => ((PhysicsRaycaster)o).maxRayIntersections,
					Updater = delegate(object o, ref object v)
					{
						int maxRayIntersections = ((PhysicsRaycaster)o).maxRayIntersections;
						if (!maxRayIntersections.Equals((int)v))
						{
							v = maxRayIntersections;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PhysicsRaycaster)o).enabled = (bool)v;
					},
					Getter = (object o) => ((PhysicsRaycaster)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((PhysicsRaycaster)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.PlatformEffector2D",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useColliderMask",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PlatformEffector2D)o).useColliderMask = (bool)v;
					},
					Getter = (object o) => ((PlatformEffector2D)o).useColliderMask,
					Updater = delegate(object o, ref object v)
					{
						bool useColliderMask = ((PlatformEffector2D)o).useColliderMask;
						if (!useColliderMask.Equals((bool)v))
						{
							v = useColliderMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colliderMask",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((PlatformEffector2D)o).colliderMask = (int)v;
					},
					Getter = (object o) => ((PlatformEffector2D)o).colliderMask,
					Updater = delegate(object o, ref object v)
					{
						int colliderMask = ((PlatformEffector2D)o).colliderMask;
						if (!colliderMask.Equals((int)v))
						{
							v = colliderMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationalOffset",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((PlatformEffector2D)o).rotationalOffset = (float)v;
					},
					Getter = (object o) => ((PlatformEffector2D)o).rotationalOffset,
					Updater = delegate(object o, ref object v)
					{
						float rotationalOffset = ((PlatformEffector2D)o).rotationalOffset;
						if (!rotationalOffset.Equals((float)v))
						{
							v = rotationalOffset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useOneWay",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PlatformEffector2D)o).useOneWay = (bool)v;
					},
					Getter = (object o) => ((PlatformEffector2D)o).useOneWay,
					Updater = delegate(object o, ref object v)
					{
						bool useOneWay = ((PlatformEffector2D)o).useOneWay;
						if (!useOneWay.Equals((bool)v))
						{
							v = useOneWay;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useOneWayGrouping",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PlatformEffector2D)o).useOneWayGrouping = (bool)v;
					},
					Getter = (object o) => ((PlatformEffector2D)o).useOneWayGrouping,
					Updater = delegate(object o, ref object v)
					{
						bool useOneWayGrouping = ((PlatformEffector2D)o).useOneWayGrouping;
						if (!useOneWayGrouping.Equals((bool)v))
						{
							v = useOneWayGrouping;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "surfaceArc",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((PlatformEffector2D)o).surfaceArc = (float)v;
					},
					Getter = (object o) => ((PlatformEffector2D)o).surfaceArc,
					Updater = delegate(object o, ref object v)
					{
						float surfaceArc = ((PlatformEffector2D)o).surfaceArc;
						if (!surfaceArc.Equals((float)v))
						{
							v = surfaceArc;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useSideFriction",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PlatformEffector2D)o).useSideFriction = (bool)v;
					},
					Getter = (object o) => ((PlatformEffector2D)o).useSideFriction,
					Updater = delegate(object o, ref object v)
					{
						bool useSideFriction = ((PlatformEffector2D)o).useSideFriction;
						if (!useSideFriction.Equals((bool)v))
						{
							v = useSideFriction;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useSideBounce",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PlatformEffector2D)o).useSideBounce = (bool)v;
					},
					Getter = (object o) => ((PlatformEffector2D)o).useSideBounce,
					Updater = delegate(object o, ref object v)
					{
						bool useSideBounce = ((PlatformEffector2D)o).useSideBounce;
						if (!useSideBounce.Equals((bool)v))
						{
							v = useSideBounce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sideArc",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((PlatformEffector2D)o).sideArc = (float)v;
					},
					Getter = (object o) => ((PlatformEffector2D)o).sideArc,
					Updater = delegate(object o, ref object v)
					{
						float sideArc = ((PlatformEffector2D)o).sideArc;
						if (!sideArc.Equals((float)v))
						{
							v = sideArc;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PlatformEffector2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((PlatformEffector2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((PlatformEffector2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Playables.PlayableDirector",
			new ProximaComponentCommands.PropertyInfo[7]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "playableAsset",
					PropertyType = typeof(PlayableAsset),
					Setter = (object o, object v) =>
					{
						((PlayableDirector)o).playableAsset = (PlayableAsset)v;
					},
					Getter = (object o) => ((PlayableDirector)o).playableAsset
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "timeUpdateMode",
					PropertyType = typeof(DirectorUpdateMode),
					Setter = (object o, object v) =>
					{
						((PlayableDirector)o).timeUpdateMode = (DirectorUpdateMode)v;
					},
					Getter = (object o) => ((PlayableDirector)o).timeUpdateMode,
					Updater = delegate(object o, ref object v)
					{
						int timeUpdateMode = (int)((PlayableDirector)o).timeUpdateMode;
						if (!timeUpdateMode.Equals((int)v))
						{
							v = timeUpdateMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "playOnAwake",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PlayableDirector)o).playOnAwake = (bool)v;
					},
					Getter = (object o) => ((PlayableDirector)o).playOnAwake,
					Updater = delegate(object o, ref object v)
					{
						bool playOnAwake = ((PlayableDirector)o).playOnAwake;
						if (!playOnAwake.Equals((bool)v))
						{
							v = playOnAwake;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "extrapolationMode",
					PropertyType = typeof(DirectorWrapMode),
					Setter = (object o, object v) =>
					{
						((PlayableDirector)o).extrapolationMode = (DirectorWrapMode)v;
					},
					Getter = (object o) => ((PlayableDirector)o).extrapolationMode,
					Updater = delegate(object o, ref object v)
					{
						int extrapolationMode = (int)((PlayableDirector)o).extrapolationMode;
						if (!extrapolationMode.Equals((int)v))
						{
							v = extrapolationMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "initialTime",
					PropertyType = typeof(double),
					Setter = (object o, object v) =>
					{
						((PlayableDirector)o).initialTime = (double)v;
					},
					Getter = (object o) => ((PlayableDirector)o).initialTime,
					Updater = delegate(object o, ref object v)
					{
						double initialTime = ((PlayableDirector)o).initialTime;
						if (!initialTime.Equals((double)v))
						{
							v = initialTime;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "time",
					PropertyType = typeof(double),
					Setter = (object o, object v) =>
					{
						((PlayableDirector)o).time = (double)v;
					},
					Getter = (object o) => ((PlayableDirector)o).time,
					Updater = delegate(object o, ref object v)
					{
						double time = ((PlayableDirector)o).time;
						if (!time.Equals((double)v))
						{
							v = time;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PlayableDirector)o).enabled = (bool)v;
					},
					Getter = (object o) => ((PlayableDirector)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((PlayableDirector)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.PointEffector2D",
			new ProximaComponentCommands.PropertyInfo[11]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useColliderMask",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PointEffector2D)o).useColliderMask = (bool)v;
					},
					Getter = (object o) => ((PointEffector2D)o).useColliderMask,
					Updater = delegate(object o, ref object v)
					{
						bool useColliderMask = ((PointEffector2D)o).useColliderMask;
						if (!useColliderMask.Equals((bool)v))
						{
							v = useColliderMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colliderMask",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((PointEffector2D)o).colliderMask = (int)v;
					},
					Getter = (object o) => ((PointEffector2D)o).colliderMask,
					Updater = delegate(object o, ref object v)
					{
						int colliderMask = ((PointEffector2D)o).colliderMask;
						if (!colliderMask.Equals((int)v))
						{
							v = colliderMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "forceMagnitude",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((PointEffector2D)o).forceMagnitude = (float)v;
					},
					Getter = (object o) => ((PointEffector2D)o).forceMagnitude,
					Updater = delegate(object o, ref object v)
					{
						float forceMagnitude = ((PointEffector2D)o).forceMagnitude;
						if (!forceMagnitude.Equals((float)v))
						{
							v = forceMagnitude;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "forceVariation",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((PointEffector2D)o).forceVariation = (float)v;
					},
					Getter = (object o) => ((PointEffector2D)o).forceVariation,
					Updater = delegate(object o, ref object v)
					{
						float forceVariation = ((PointEffector2D)o).forceVariation;
						if (!forceVariation.Equals((float)v))
						{
							v = forceVariation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "distanceScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((PointEffector2D)o).distanceScale = (float)v;
					},
					Getter = (object o) => ((PointEffector2D)o).distanceScale,
					Updater = delegate(object o, ref object v)
					{
						float distanceScale = ((PointEffector2D)o).distanceScale;
						if (!distanceScale.Equals((float)v))
						{
							v = distanceScale;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "forceSource",
					PropertyType = typeof(EffectorSelection2D),
					Setter = (object o, object v) =>
					{
						((PointEffector2D)o).forceSource = (EffectorSelection2D)v;
					},
					Getter = (object o) => ((PointEffector2D)o).forceSource,
					Updater = delegate(object o, ref object v)
					{
						int forceSource = (int)((PointEffector2D)o).forceSource;
						if (!forceSource.Equals((int)v))
						{
							v = forceSource;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "forceTarget",
					PropertyType = typeof(EffectorSelection2D),
					Setter = (object o, object v) =>
					{
						((PointEffector2D)o).forceTarget = (EffectorSelection2D)v;
					},
					Getter = (object o) => ((PointEffector2D)o).forceTarget,
					Updater = delegate(object o, ref object v)
					{
						int forceTarget = (int)((PointEffector2D)o).forceTarget;
						if (!forceTarget.Equals((int)v))
						{
							v = forceTarget;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "forceMode",
					PropertyType = typeof(EffectorForceMode2D),
					Setter = (object o, object v) =>
					{
						((PointEffector2D)o).forceMode = (EffectorForceMode2D)v;
					},
					Getter = (object o) => ((PointEffector2D)o).forceMode,
					Updater = delegate(object o, ref object v)
					{
						int forceMode = (int)((PointEffector2D)o).forceMode;
						if (!forceMode.Equals((int)v))
						{
							v = forceMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "drag",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((PointEffector2D)o).drag = (float)v;
					},
					Getter = (object o) => ((PointEffector2D)o).drag,
					Updater = delegate(object o, ref object v)
					{
						float drag = ((PointEffector2D)o).drag;
						if (!drag.Equals((float)v))
						{
							v = drag;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularDrag",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((PointEffector2D)o).angularDrag = (float)v;
					},
					Getter = (object o) => ((PointEffector2D)o).angularDrag,
					Updater = delegate(object o, ref object v)
					{
						float angularDrag = ((PointEffector2D)o).angularDrag;
						if (!angularDrag.Equals((float)v))
						{
							v = angularDrag;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PointEffector2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((PointEffector2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((PointEffector2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.PolygonCollider2D",
			new ProximaComponentCommands.PropertyInfo[9]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterial",
					PropertyType = typeof(PhysicsMaterial2D),
					Setter = (object o, object v) =>
					{
						((PolygonCollider2D)o).sharedMaterial = (PhysicsMaterial2D)v;
					},
					Getter = (object o) => ((PolygonCollider2D)o).sharedMaterial
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTrigger",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PolygonCollider2D)o).isTrigger = (bool)v;
					},
					Getter = (object o) => ((PolygonCollider2D)o).isTrigger,
					Updater = delegate(object o, ref object v)
					{
						bool isTrigger = ((PolygonCollider2D)o).isTrigger;
						if (!isTrigger.Equals((bool)v))
						{
							v = isTrigger;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByEffector",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PolygonCollider2D)o).usedByEffector = (bool)v;
					},
					Getter = (object o) => ((PolygonCollider2D)o).usedByEffector,
					Updater = delegate(object o, ref object v)
					{
						bool usedByEffector = ((PolygonCollider2D)o).usedByEffector;
						if (!usedByEffector.Equals((bool)v))
						{
							v = usedByEffector;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "usedByComposite",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PolygonCollider2D)o).usedByComposite = (bool)v;
					},
					Getter = (object o) => ((PolygonCollider2D)o).usedByComposite,
					Updater = delegate(object o, ref object v)
					{
						bool usedByComposite = ((PolygonCollider2D)o).usedByComposite;
						if (!usedByComposite.Equals((bool)v))
						{
							v = usedByComposite;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoTiling",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PolygonCollider2D)o).autoTiling = (bool)v;
					},
					Getter = (object o) => ((PolygonCollider2D)o).autoTiling,
					Updater = delegate(object o, ref object v)
					{
						bool autoTiling = ((PolygonCollider2D)o).autoTiling;
						if (!autoTiling.Equals((bool)v))
						{
							v = autoTiling;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "offset",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((PolygonCollider2D)o).offset = (Vector2)v;
					},
					Getter = (object o) => ((PolygonCollider2D)o).offset,
					Updater = delegate(object o, ref object v)
					{
						Vector2 offset = ((PolygonCollider2D)o).offset;
						if (!offset.Equals((Vector2)v))
						{
							v = offset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "pathCount",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((PolygonCollider2D)o).pathCount = (int)v;
					},
					Getter = (object o) => ((PolygonCollider2D)o).pathCount,
					Updater = delegate(object o, ref object v)
					{
						int pathCount = ((PolygonCollider2D)o).pathCount;
						if (!pathCount.Equals((int)v))
						{
							v = pathCount;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "points",
					PropertyType = typeof(Vector2[]),
					Setter = (object o, object v) =>
					{
						((PolygonCollider2D)o).points = (Vector2[])v;
					},
					Getter = (object o) => ((PolygonCollider2D)o).points
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PolygonCollider2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((PolygonCollider2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((PolygonCollider2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Animations.PositionConstraint",
			new ProximaComponentCommands.PropertyInfo[7]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "constraintActive",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PositionConstraint)o).constraintActive = (bool)v;
					},
					Getter = (object o) => ((PositionConstraint)o).constraintActive,
					Updater = delegate(object o, ref object v)
					{
						bool constraintActive = ((PositionConstraint)o).constraintActive;
						if (!constraintActive.Equals((bool)v))
						{
							v = constraintActive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "weight",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((PositionConstraint)o).weight = (float)v;
					},
					Getter = (object o) => ((PositionConstraint)o).weight,
					Updater = delegate(object o, ref object v)
					{
						float weight = ((PositionConstraint)o).weight;
						if (!weight.Equals((float)v))
						{
							v = weight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "locked",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PositionConstraint)o).locked = (bool)v;
					},
					Getter = (object o) => ((PositionConstraint)o).locked,
					Updater = delegate(object o, ref object v)
					{
						bool locked = ((PositionConstraint)o).locked;
						if (!locked.Equals((bool)v))
						{
							v = locked;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "translationAtRest",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((PositionConstraint)o).translationAtRest = (Vector3)v;
					},
					Getter = (object o) => ((PositionConstraint)o).translationAtRest,
					Updater = delegate(object o, ref object v)
					{
						Vector3 translationAtRest = ((PositionConstraint)o).translationAtRest;
						if (!translationAtRest.Equals((Vector3)v))
						{
							v = translationAtRest;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "translationOffset",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((PositionConstraint)o).translationOffset = (Vector3)v;
					},
					Getter = (object o) => ((PositionConstraint)o).translationOffset,
					Updater = delegate(object o, ref object v)
					{
						Vector3 translationOffset = ((PositionConstraint)o).translationOffset;
						if (!translationOffset.Equals((Vector3)v))
						{
							v = translationOffset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "translationAxis",
					PropertyType = typeof(Axis),
					Setter = (object o, object v) =>
					{
						((PositionConstraint)o).translationAxis = (Axis)v;
					},
					Getter = (object o) => ((PositionConstraint)o).translationAxis,
					Updater = delegate(object o, ref object v)
					{
						int translationAxis = (int)((PositionConstraint)o).translationAxis;
						if (!translationAxis.Equals((int)v))
						{
							v = translationAxis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((PositionConstraint)o).enabled = (bool)v;
					},
					Getter = (object o) => ((PositionConstraint)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((PositionConstraint)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Projector",
			new ProximaComponentCommands.PropertyInfo[9]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "nearClipPlane",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Projector)o).nearClipPlane = (float)v;
					},
					Getter = (object o) => ((Projector)o).nearClipPlane,
					Updater = delegate(object o, ref object v)
					{
						float nearClipPlane = ((Projector)o).nearClipPlane;
						if (!nearClipPlane.Equals((float)v))
						{
							v = nearClipPlane;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "farClipPlane",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Projector)o).farClipPlane = (float)v;
					},
					Getter = (object o) => ((Projector)o).farClipPlane,
					Updater = delegate(object o, ref object v)
					{
						float farClipPlane = ((Projector)o).farClipPlane;
						if (!farClipPlane.Equals((float)v))
						{
							v = farClipPlane;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fieldOfView",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Projector)o).fieldOfView = (float)v;
					},
					Getter = (object o) => ((Projector)o).fieldOfView,
					Updater = delegate(object o, ref object v)
					{
						float fieldOfView = ((Projector)o).fieldOfView;
						if (!fieldOfView.Equals((float)v))
						{
							v = fieldOfView;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "aspectRatio",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Projector)o).aspectRatio = (float)v;
					},
					Getter = (object o) => ((Projector)o).aspectRatio,
					Updater = delegate(object o, ref object v)
					{
						float aspectRatio = ((Projector)o).aspectRatio;
						if (!aspectRatio.Equals((float)v))
						{
							v = aspectRatio;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "orthographic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Projector)o).orthographic = (bool)v;
					},
					Getter = (object o) => ((Projector)o).orthographic,
					Updater = delegate(object o, ref object v)
					{
						bool orthographic = ((Projector)o).orthographic;
						if (!orthographic.Equals((bool)v))
						{
							v = orthographic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "orthographicSize",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Projector)o).orthographicSize = (float)v;
					},
					Getter = (object o) => ((Projector)o).orthographicSize,
					Updater = delegate(object o, ref object v)
					{
						float orthographicSize = ((Projector)o).orthographicSize;
						if (!orthographicSize.Equals((float)v))
						{
							v = orthographicSize;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "material",
					PropertyType = typeof(Material),
					Setter = (object o, object v) =>
					{
						((Projector)o).material = (Material)v;
					},
					Getter = (object o) => ((Projector)o).material
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "ignoreLayers",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((Projector)o).ignoreLayers = (int)v;
					},
					Getter = (object o) => ((Projector)o).ignoreLayers,
					Updater = delegate(object o, ref object v)
					{
						int ignoreLayers = ((Projector)o).ignoreLayers;
						if (!ignoreLayers.Equals((int)v))
						{
							v = ignoreLayers;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Projector)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Projector)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Projector)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.RawImage",
			new ProximaComponentCommands.PropertyInfo[7]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "texture",
					PropertyType = typeof(Texture),
					Setter = (object o, object v) =>
					{
						((RawImage)o).texture = (Texture)v;
					},
					Getter = (object o) => ((RawImage)o).texture
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "color",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((RawImage)o).color = (Color)v;
					},
					Getter = (object o) => ((RawImage)o).color,
					Updater = delegate(object o, ref object v)
					{
						Color color = ((RawImage)o).color;
						if (!color.Equals((Color)v))
						{
							v = color;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "raycastTarget",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((RawImage)o).raycastTarget = (bool)v;
					},
					Getter = (object o) => ((RawImage)o).raycastTarget,
					Updater = delegate(object o, ref object v)
					{
						bool raycastTarget = ((RawImage)o).raycastTarget;
						if (!raycastTarget.Equals((bool)v))
						{
							v = raycastTarget;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "raycastPadding",
					PropertyType = typeof(Vector4),
					Setter = (object o, object v) =>
					{
						((RawImage)o).raycastPadding = (Vector4)v;
					},
					Getter = (object o) => ((RawImage)o).raycastPadding,
					Updater = delegate(object o, ref object v)
					{
						Vector4 raycastPadding = ((RawImage)o).raycastPadding;
						if (!raycastPadding.Equals((Vector4)v))
						{
							v = raycastPadding;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maskable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((RawImage)o).maskable = (bool)v;
					},
					Getter = (object o) => ((RawImage)o).maskable,
					Updater = delegate(object o, ref object v)
					{
						bool maskable = ((RawImage)o).maskable;
						if (!maskable.Equals((bool)v))
						{
							v = maskable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "uvRect",
					PropertyType = typeof(Rect),
					Setter = (object o, object v) =>
					{
						((RawImage)o).uvRect = (Rect)v;
					},
					Getter = (object o) => ((RawImage)o).uvRect,
					Updater = delegate(object o, ref object v)
					{
						Rect uvRect = ((RawImage)o).uvRect;
						if (!uvRect.Equals((Rect)v))
						{
							v = uvRect;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((RawImage)o).enabled = (bool)v;
					},
					Getter = (object o) => ((RawImage)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((RawImage)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.RectMask2D",
			new ProximaComponentCommands.PropertyInfo[3]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "padding",
					PropertyType = typeof(Vector4),
					Setter = (object o, object v) =>
					{
						((RectMask2D)o).padding = (Vector4)v;
					},
					Getter = (object o) => ((RectMask2D)o).padding,
					Updater = delegate(object o, ref object v)
					{
						Vector4 padding = ((RectMask2D)o).padding;
						if (!padding.Equals((Vector4)v))
						{
							v = padding;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "softness",
					PropertyType = typeof(Vector2Int),
					Setter = (object o, object v) =>
					{
						((RectMask2D)o).softness = (Vector2Int)v;
					},
					Getter = (object o) => ((RectMask2D)o).softness,
					Updater = delegate(object o, ref object v)
					{
						Vector2Int softness = ((RectMask2D)o).softness;
						if (!softness.Equals((Vector2Int)v))
						{
							v = softness;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((RectMask2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((RectMask2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((RectMask2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.RectTransform",
			new ProximaComponentCommands.PropertyInfo[6]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "localPosition",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((RectTransform)o).localPosition = (Vector3)v;
					},
					Getter = (object o) => ((RectTransform)o).localPosition,
					Updater = delegate(object o, ref object v)
					{
						Vector3 localPosition = ((RectTransform)o).localPosition;
						if (!localPosition.Equals((Vector3)v))
						{
							v = localPosition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sizeDelta",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((RectTransform)o).sizeDelta = (Vector2)v;
					},
					Getter = (object o) => ((RectTransform)o).sizeDelta,
					Updater = delegate(object o, ref object v)
					{
						Vector2 sizeDelta = ((RectTransform)o).sizeDelta;
						if (!sizeDelta.Equals((Vector2)v))
						{
							v = sizeDelta;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchorMin",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((RectTransform)o).anchorMin = (Vector2)v;
					},
					Getter = (object o) => ((RectTransform)o).anchorMin,
					Updater = delegate(object o, ref object v)
					{
						Vector2 anchorMin = ((RectTransform)o).anchorMin;
						if (!anchorMin.Equals((Vector2)v))
						{
							v = anchorMin;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchorMax",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((RectTransform)o).anchorMax = (Vector2)v;
					},
					Getter = (object o) => ((RectTransform)o).anchorMax,
					Updater = delegate(object o, ref object v)
					{
						Vector2 anchorMax = ((RectTransform)o).anchorMax;
						if (!anchorMax.Equals((Vector2)v))
						{
							v = anchorMax;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "localRotation",
					PropertyType = typeof(Quaternion),
					Setter = (object o, object v) =>
					{
						((RectTransform)o).localRotation = (Quaternion)v;
					},
					Getter = (object o) => ((RectTransform)o).localRotation,
					Updater = delegate(object o, ref object v)
					{
						Quaternion localRotation = ((RectTransform)o).localRotation;
						if (!localRotation.Equals((Quaternion)v))
						{
							v = localRotation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "localScale",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((RectTransform)o).localScale = (Vector3)v;
					},
					Getter = (object o) => ((RectTransform)o).localScale,
					Updater = delegate(object o, ref object v)
					{
						Vector3 localScale = ((RectTransform)o).localScale;
						if (!localScale.Equals((Vector3)v))
						{
							v = localScale;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.ReflectionProbe",
			new ProximaComponentCommands.PropertyInfo[16]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "mode",
					PropertyType = typeof(ReflectionProbeMode),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).mode = (ReflectionProbeMode)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).mode,
					Updater = delegate(object o, ref object v)
					{
						int mode = (int)((ReflectionProbe)o).mode;
						if (!mode.Equals((int)v))
						{
							v = mode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "importance",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).importance = (int)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).importance,
					Updater = delegate(object o, ref object v)
					{
						int importance = ((ReflectionProbe)o).importance;
						if (!importance.Equals((int)v))
						{
							v = importance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "intensity",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).intensity = (float)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).intensity,
					Updater = delegate(object o, ref object v)
					{
						float intensity = ((ReflectionProbe)o).intensity;
						if (!intensity.Equals((float)v))
						{
							v = intensity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "boxProjection",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).boxProjection = (bool)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).boxProjection,
					Updater = delegate(object o, ref object v)
					{
						bool boxProjection = ((ReflectionProbe)o).boxProjection;
						if (!boxProjection.Equals((bool)v))
						{
							v = boxProjection;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "blendDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).blendDistance = (float)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).blendDistance,
					Updater = delegate(object o, ref object v)
					{
						float blendDistance = ((ReflectionProbe)o).blendDistance;
						if (!blendDistance.Equals((float)v))
						{
							v = blendDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "size",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).size = (Vector3)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).size,
					Updater = delegate(object o, ref object v)
					{
						Vector3 size = ((ReflectionProbe)o).size;
						if (!size.Equals((Vector3)v))
						{
							v = size;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "center",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).center = (Vector3)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).center,
					Updater = delegate(object o, ref object v)
					{
						Vector3 center = ((ReflectionProbe)o).center;
						if (!center.Equals((Vector3)v))
						{
							v = center;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "resolution",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).resolution = (int)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).resolution,
					Updater = delegate(object o, ref object v)
					{
						int resolution = ((ReflectionProbe)o).resolution;
						if (!resolution.Equals((int)v))
						{
							v = resolution;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "hdr",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).hdr = (bool)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).hdr,
					Updater = delegate(object o, ref object v)
					{
						bool hdr = ((ReflectionProbe)o).hdr;
						if (!hdr.Equals((bool)v))
						{
							v = hdr;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shadowDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).shadowDistance = (float)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).shadowDistance,
					Updater = delegate(object o, ref object v)
					{
						float shadowDistance = ((ReflectionProbe)o).shadowDistance;
						if (!shadowDistance.Equals((float)v))
						{
							v = shadowDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "clearFlags",
					PropertyType = typeof(ReflectionProbeClearFlags),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).clearFlags = (ReflectionProbeClearFlags)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).clearFlags,
					Updater = delegate(object o, ref object v)
					{
						int clearFlags = (int)((ReflectionProbe)o).clearFlags;
						if (!clearFlags.Equals((int)v))
						{
							v = clearFlags;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "backgroundColor",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).backgroundColor = (Color)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).backgroundColor,
					Updater = delegate(object o, ref object v)
					{
						Color backgroundColor = ((ReflectionProbe)o).backgroundColor;
						if (!backgroundColor.Equals((Color)v))
						{
							v = backgroundColor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cullingMask",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).cullingMask = (int)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).cullingMask,
					Updater = delegate(object o, ref object v)
					{
						int cullingMask = ((ReflectionProbe)o).cullingMask;
						if (!cullingMask.Equals((int)v))
						{
							v = cullingMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "nearClipPlane",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).nearClipPlane = (float)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).nearClipPlane,
					Updater = delegate(object o, ref object v)
					{
						float nearClipPlane = ((ReflectionProbe)o).nearClipPlane;
						if (!nearClipPlane.Equals((float)v))
						{
							v = nearClipPlane;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "farClipPlane",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).farClipPlane = (float)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).farClipPlane,
					Updater = delegate(object o, ref object v)
					{
						float farClipPlane = ((ReflectionProbe)o).farClipPlane;
						if (!farClipPlane.Equals((float)v))
						{
							v = farClipPlane;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ReflectionProbe)o).enabled = (bool)v;
					},
					Getter = (object o) => ((ReflectionProbe)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((ReflectionProbe)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.RelativeJoint2D",
			new ProximaComponentCommands.PropertyInfo[11]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((RelativeJoint2D)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((RelativeJoint2D)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((RelativeJoint2D)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody2D),
					Setter = (object o, object v) =>
					{
						((RelativeJoint2D)o).connectedBody = (Rigidbody2D)v;
					},
					Getter = (object o) => ((RelativeJoint2D)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((RelativeJoint2D)o).maxForce = (float)v;
					},
					Getter = (object o) => ((RelativeJoint2D)o).maxForce,
					Updater = delegate(object o, ref object v)
					{
						float maxForce = ((RelativeJoint2D)o).maxForce;
						if (!maxForce.Equals((float)v))
						{
							v = maxForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((RelativeJoint2D)o).maxTorque = (float)v;
					},
					Getter = (object o) => ((RelativeJoint2D)o).maxTorque,
					Updater = delegate(object o, ref object v)
					{
						float maxTorque = ((RelativeJoint2D)o).maxTorque;
						if (!maxTorque.Equals((float)v))
						{
							v = maxTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "correctionScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((RelativeJoint2D)o).correctionScale = (float)v;
					},
					Getter = (object o) => ((RelativeJoint2D)o).correctionScale,
					Updater = delegate(object o, ref object v)
					{
						float correctionScale = ((RelativeJoint2D)o).correctionScale;
						if (!correctionScale.Equals((float)v))
						{
							v = correctionScale;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureOffset",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((RelativeJoint2D)o).autoConfigureOffset = (bool)v;
					},
					Getter = (object o) => ((RelativeJoint2D)o).autoConfigureOffset,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureOffset = ((RelativeJoint2D)o).autoConfigureOffset;
						if (!autoConfigureOffset.Equals((bool)v))
						{
							v = autoConfigureOffset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "linearOffset",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((RelativeJoint2D)o).linearOffset = (Vector2)v;
					},
					Getter = (object o) => ((RelativeJoint2D)o).linearOffset,
					Updater = delegate(object o, ref object v)
					{
						Vector2 linearOffset = ((RelativeJoint2D)o).linearOffset;
						if (!linearOffset.Equals((Vector2)v))
						{
							v = linearOffset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularOffset",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((RelativeJoint2D)o).angularOffset = (float)v;
					},
					Getter = (object o) => ((RelativeJoint2D)o).angularOffset,
					Updater = delegate(object o, ref object v)
					{
						float angularOffset = ((RelativeJoint2D)o).angularOffset;
						if (!angularOffset.Equals((float)v))
						{
							v = angularOffset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((RelativeJoint2D)o).breakForce = (float)v;
					},
					Getter = (object o) => ((RelativeJoint2D)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((RelativeJoint2D)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((RelativeJoint2D)o).breakTorque = (float)v;
					},
					Getter = (object o) => ((RelativeJoint2D)o).breakTorque,
					Updater = delegate(object o, ref object v)
					{
						float breakTorque = ((RelativeJoint2D)o).breakTorque;
						if (!breakTorque.Equals((float)v))
						{
							v = breakTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((RelativeJoint2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((RelativeJoint2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((RelativeJoint2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Rigidbody",
			new ProximaComponentCommands.PropertyInfo[8]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "mass",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Rigidbody)o).mass = (float)v;
					},
					Getter = (object o) => ((Rigidbody)o).mass,
					Updater = delegate(object o, ref object v)
					{
						float mass = ((Rigidbody)o).mass;
						if (!mass.Equals((float)v))
						{
							v = mass;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "drag",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Rigidbody)o).drag = (float)v;
					},
					Getter = (object o) => ((Rigidbody)o).drag,
					Updater = delegate(object o, ref object v)
					{
						float drag = ((Rigidbody)o).drag;
						if (!drag.Equals((float)v))
						{
							v = drag;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularDrag",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Rigidbody)o).angularDrag = (float)v;
					},
					Getter = (object o) => ((Rigidbody)o).angularDrag,
					Updater = delegate(object o, ref object v)
					{
						float angularDrag = ((Rigidbody)o).angularDrag;
						if (!angularDrag.Equals((float)v))
						{
							v = angularDrag;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useGravity",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Rigidbody)o).useGravity = (bool)v;
					},
					Getter = (object o) => ((Rigidbody)o).useGravity,
					Updater = delegate(object o, ref object v)
					{
						bool useGravity = ((Rigidbody)o).useGravity;
						if (!useGravity.Equals((bool)v))
						{
							v = useGravity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isKinematic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Rigidbody)o).isKinematic = (bool)v;
					},
					Getter = (object o) => ((Rigidbody)o).isKinematic,
					Updater = delegate(object o, ref object v)
					{
						bool isKinematic = ((Rigidbody)o).isKinematic;
						if (!isKinematic.Equals((bool)v))
						{
							v = isKinematic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "interpolation",
					PropertyType = typeof(RigidbodyInterpolation),
					Setter = (object o, object v) =>
					{
						((Rigidbody)o).interpolation = (RigidbodyInterpolation)v;
					},
					Getter = (object o) => ((Rigidbody)o).interpolation,
					Updater = delegate(object o, ref object v)
					{
						int interpolation = (int)((Rigidbody)o).interpolation;
						if (!interpolation.Equals((int)v))
						{
							v = interpolation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "collisionDetectionMode",
					PropertyType = typeof(CollisionDetectionMode),
					Setter = (object o, object v) =>
					{
						((Rigidbody)o).collisionDetectionMode = (CollisionDetectionMode)v;
					},
					Getter = (object o) => ((Rigidbody)o).collisionDetectionMode,
					Updater = delegate(object o, ref object v)
					{
						int collisionDetectionMode = (int)((Rigidbody)o).collisionDetectionMode;
						if (!collisionDetectionMode.Equals((int)v))
						{
							v = collisionDetectionMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "constraints",
					PropertyType = typeof(RigidbodyConstraints),
					Setter = (object o, object v) =>
					{
						((Rigidbody)o).constraints = (RigidbodyConstraints)v;
					},
					Getter = (object o) => ((Rigidbody)o).constraints,
					Updater = delegate(object o, ref object v)
					{
						int constraints = (int)((Rigidbody)o).constraints;
						if (!constraints.Equals((int)v))
						{
							v = constraints;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Rigidbody2D",
			new ProximaComponentCommands.PropertyInfo[11]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "bodyType",
					PropertyType = typeof(RigidbodyType2D),
					Setter = (object o, object v) =>
					{
						((Rigidbody2D)o).bodyType = (RigidbodyType2D)v;
					},
					Getter = (object o) => ((Rigidbody2D)o).bodyType,
					Updater = delegate(object o, ref object v)
					{
						int bodyType = (int)((Rigidbody2D)o).bodyType;
						if (!bodyType.Equals((int)v))
						{
							v = bodyType;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "simulated",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Rigidbody2D)o).simulated = (bool)v;
					},
					Getter = (object o) => ((Rigidbody2D)o).simulated,
					Updater = delegate(object o, ref object v)
					{
						bool simulated = ((Rigidbody2D)o).simulated;
						if (!simulated.Equals((bool)v))
						{
							v = simulated;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useAutoMass",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Rigidbody2D)o).useAutoMass = (bool)v;
					},
					Getter = (object o) => ((Rigidbody2D)o).useAutoMass,
					Updater = delegate(object o, ref object v)
					{
						bool useAutoMass = ((Rigidbody2D)o).useAutoMass;
						if (!useAutoMass.Equals((bool)v))
						{
							v = useAutoMass;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "mass",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Rigidbody2D)o).mass = (float)v;
					},
					Getter = (object o) => ((Rigidbody2D)o).mass,
					Updater = delegate(object o, ref object v)
					{
						float mass = ((Rigidbody2D)o).mass;
						if (!mass.Equals((float)v))
						{
							v = mass;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "drag",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Rigidbody2D)o).drag = (float)v;
					},
					Getter = (object o) => ((Rigidbody2D)o).drag,
					Updater = delegate(object o, ref object v)
					{
						float drag = ((Rigidbody2D)o).drag;
						if (!drag.Equals((float)v))
						{
							v = drag;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angularDrag",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Rigidbody2D)o).angularDrag = (float)v;
					},
					Getter = (object o) => ((Rigidbody2D)o).angularDrag,
					Updater = delegate(object o, ref object v)
					{
						float angularDrag = ((Rigidbody2D)o).angularDrag;
						if (!angularDrag.Equals((float)v))
						{
							v = angularDrag;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "gravityScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Rigidbody2D)o).gravityScale = (float)v;
					},
					Getter = (object o) => ((Rigidbody2D)o).gravityScale,
					Updater = delegate(object o, ref object v)
					{
						float gravityScale = ((Rigidbody2D)o).gravityScale;
						if (!gravityScale.Equals((float)v))
						{
							v = gravityScale;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "collisionDetectionMode",
					PropertyType = typeof(CollisionDetectionMode2D),
					Setter = (object o, object v) =>
					{
						((Rigidbody2D)o).collisionDetectionMode = (CollisionDetectionMode2D)v;
					},
					Getter = (object o) => ((Rigidbody2D)o).collisionDetectionMode,
					Updater = delegate(object o, ref object v)
					{
						int collisionDetectionMode = (int)((Rigidbody2D)o).collisionDetectionMode;
						if (!collisionDetectionMode.Equals((int)v))
						{
							v = collisionDetectionMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sleepMode",
					PropertyType = typeof(RigidbodySleepMode2D),
					Setter = (object o, object v) =>
					{
						((Rigidbody2D)o).sleepMode = (RigidbodySleepMode2D)v;
					},
					Getter = (object o) => ((Rigidbody2D)o).sleepMode,
					Updater = delegate(object o, ref object v)
					{
						int sleepMode = (int)((Rigidbody2D)o).sleepMode;
						if (!sleepMode.Equals((int)v))
						{
							v = sleepMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "interpolation",
					PropertyType = typeof(RigidbodyInterpolation2D),
					Setter = (object o, object v) =>
					{
						((Rigidbody2D)o).interpolation = (RigidbodyInterpolation2D)v;
					},
					Getter = (object o) => ((Rigidbody2D)o).interpolation,
					Updater = delegate(object o, ref object v)
					{
						int interpolation = (int)((Rigidbody2D)o).interpolation;
						if (!interpolation.Equals((int)v))
						{
							v = interpolation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "constraints",
					PropertyType = typeof(RigidbodyConstraints2D),
					Setter = (object o, object v) =>
					{
						((Rigidbody2D)o).constraints = (RigidbodyConstraints2D)v;
					},
					Getter = (object o) => ((Rigidbody2D)o).constraints,
					Updater = delegate(object o, ref object v)
					{
						int constraints = (int)((Rigidbody2D)o).constraints;
						if (!constraints.Equals((int)v))
						{
							v = constraints;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Animations.RotationConstraint",
			new ProximaComponentCommands.PropertyInfo[7]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "constraintActive",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((RotationConstraint)o).constraintActive = (bool)v;
					},
					Getter = (object o) => ((RotationConstraint)o).constraintActive,
					Updater = delegate(object o, ref object v)
					{
						bool constraintActive = ((RotationConstraint)o).constraintActive;
						if (!constraintActive.Equals((bool)v))
						{
							v = constraintActive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "weight",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((RotationConstraint)o).weight = (float)v;
					},
					Getter = (object o) => ((RotationConstraint)o).weight,
					Updater = delegate(object o, ref object v)
					{
						float weight = ((RotationConstraint)o).weight;
						if (!weight.Equals((float)v))
						{
							v = weight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "locked",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((RotationConstraint)o).locked = (bool)v;
					},
					Getter = (object o) => ((RotationConstraint)o).locked,
					Updater = delegate(object o, ref object v)
					{
						bool locked = ((RotationConstraint)o).locked;
						if (!locked.Equals((bool)v))
						{
							v = locked;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationAtRest",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((RotationConstraint)o).rotationAtRest = (Vector3)v;
					},
					Getter = (object o) => ((RotationConstraint)o).rotationAtRest,
					Updater = delegate(object o, ref object v)
					{
						Vector3 rotationAtRest = ((RotationConstraint)o).rotationAtRest;
						if (!rotationAtRest.Equals((Vector3)v))
						{
							v = rotationAtRest;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationOffset",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((RotationConstraint)o).rotationOffset = (Vector3)v;
					},
					Getter = (object o) => ((RotationConstraint)o).rotationOffset,
					Updater = delegate(object o, ref object v)
					{
						Vector3 rotationOffset = ((RotationConstraint)o).rotationOffset;
						if (!rotationOffset.Equals((Vector3)v))
						{
							v = rotationOffset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rotationAxis",
					PropertyType = typeof(Axis),
					Setter = (object o, object v) =>
					{
						((RotationConstraint)o).rotationAxis = (Axis)v;
					},
					Getter = (object o) => ((RotationConstraint)o).rotationAxis,
					Updater = delegate(object o, ref object v)
					{
						int rotationAxis = (int)((RotationConstraint)o).rotationAxis;
						if (!rotationAxis.Equals((int)v))
						{
							v = rotationAxis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((RotationConstraint)o).enabled = (bool)v;
					},
					Getter = (object o) => ((RotationConstraint)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((RotationConstraint)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Animations.ScaleConstraint",
			new ProximaComponentCommands.PropertyInfo[7]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "constraintActive",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ScaleConstraint)o).constraintActive = (bool)v;
					},
					Getter = (object o) => ((ScaleConstraint)o).constraintActive,
					Updater = delegate(object o, ref object v)
					{
						bool constraintActive = ((ScaleConstraint)o).constraintActive;
						if (!constraintActive.Equals((bool)v))
						{
							v = constraintActive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "weight",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ScaleConstraint)o).weight = (float)v;
					},
					Getter = (object o) => ((ScaleConstraint)o).weight,
					Updater = delegate(object o, ref object v)
					{
						float weight = ((ScaleConstraint)o).weight;
						if (!weight.Equals((float)v))
						{
							v = weight;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "locked",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ScaleConstraint)o).locked = (bool)v;
					},
					Getter = (object o) => ((ScaleConstraint)o).locked,
					Updater = delegate(object o, ref object v)
					{
						bool locked = ((ScaleConstraint)o).locked;
						if (!locked.Equals((bool)v))
						{
							v = locked;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "scaleAtRest",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ScaleConstraint)o).scaleAtRest = (Vector3)v;
					},
					Getter = (object o) => ((ScaleConstraint)o).scaleAtRest,
					Updater = delegate(object o, ref object v)
					{
						Vector3 scaleAtRest = ((ScaleConstraint)o).scaleAtRest;
						if (!scaleAtRest.Equals((Vector3)v))
						{
							v = scaleAtRest;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "scaleOffset",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((ScaleConstraint)o).scaleOffset = (Vector3)v;
					},
					Getter = (object o) => ((ScaleConstraint)o).scaleOffset,
					Updater = delegate(object o, ref object v)
					{
						Vector3 scaleOffset = ((ScaleConstraint)o).scaleOffset;
						if (!scaleOffset.Equals((Vector3)v))
						{
							v = scaleOffset;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "scalingAxis",
					PropertyType = typeof(Axis),
					Setter = (object o, object v) =>
					{
						((ScaleConstraint)o).scalingAxis = (Axis)v;
					},
					Getter = (object o) => ((ScaleConstraint)o).scalingAxis,
					Updater = delegate(object o, ref object v)
					{
						int scalingAxis = (int)((ScaleConstraint)o).scalingAxis;
						if (!scalingAxis.Equals((int)v))
						{
							v = scalingAxis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ScaleConstraint)o).enabled = (bool)v;
					},
					Getter = (object o) => ((ScaleConstraint)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((ScaleConstraint)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.Scrollbar",
			new ProximaComponentCommands.PropertyInfo[11]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "interactable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Scrollbar)o).interactable = (bool)v;
					},
					Getter = (object o) => ((Scrollbar)o).interactable,
					Updater = delegate(object o, ref object v)
					{
						bool interactable = ((Scrollbar)o).interactable;
						if (!interactable.Equals((bool)v))
						{
							v = interactable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "transition",
					PropertyType = typeof(Selectable.Transition),
					Setter = (object o, object v) =>
					{
						((Scrollbar)o).transition = (Selectable.Transition)v;
					},
					Getter = (object o) => ((Scrollbar)o).transition,
					Updater = delegate(object o, ref object v)
					{
						int transition = (int)((Scrollbar)o).transition;
						if (!transition.Equals((int)v))
						{
							v = transition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetGraphic",
					PropertyType = typeof(Graphic),
					Setter = (object o, object v) =>
					{
						((Scrollbar)o).targetGraphic = (Graphic)v;
					},
					Getter = (object o) => ((Scrollbar)o).targetGraphic
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colors",
					PropertyType = typeof(ColorBlock),
					Setter = (object o, object v) =>
					{
						((Scrollbar)o).colors = (ColorBlock)v;
					},
					Getter = (object o) => ((Scrollbar)o).colors,
					Updater = delegate(object o, ref object v)
					{
						ColorBlock colors = ((Scrollbar)o).colors;
						if (!colors.Equals((ColorBlock)v))
						{
							v = colors;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "navigation",
					PropertyType = typeof(Navigation),
					Setter = (object o, object v) =>
					{
						((Scrollbar)o).navigation = (Navigation)v;
					},
					Getter = (object o) => ((Scrollbar)o).navigation,
					Updater = delegate(object o, ref object v)
					{
						Navigation navigation = ((Scrollbar)o).navigation;
						if (!navigation.Equals((Navigation)v))
						{
							v = navigation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "handleRect",
					PropertyType = typeof(RectTransform),
					Setter = (object o, object v) =>
					{
						((Scrollbar)o).handleRect = (RectTransform)v;
					},
					Getter = (object o) => ((Scrollbar)o).handleRect
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "direction",
					PropertyType = typeof(Scrollbar.Direction),
					Setter = (object o, object v) =>
					{
						((Scrollbar)o).direction = (Scrollbar.Direction)v;
					},
					Getter = (object o) => ((Scrollbar)o).direction,
					Updater = delegate(object o, ref object v)
					{
						int direction = (int)((Scrollbar)o).direction;
						if (!direction.Equals((int)v))
						{
							v = direction;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "value",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Scrollbar)o).value = (float)v;
					},
					Getter = (object o) => ((Scrollbar)o).value,
					Updater = delegate(object o, ref object v)
					{
						float value = ((Scrollbar)o).value;
						if (!value.Equals((float)v))
						{
							v = value;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "size",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Scrollbar)o).size = (float)v;
					},
					Getter = (object o) => ((Scrollbar)o).size,
					Updater = delegate(object o, ref object v)
					{
						float size = ((Scrollbar)o).size;
						if (!size.Equals((float)v))
						{
							v = size;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "numberOfSteps",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((Scrollbar)o).numberOfSteps = (int)v;
					},
					Getter = (object o) => ((Scrollbar)o).numberOfSteps,
					Updater = delegate(object o, ref object v)
					{
						int numberOfSteps = ((Scrollbar)o).numberOfSteps;
						if (!numberOfSteps.Equals((int)v))
						{
							v = numberOfSteps;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Scrollbar)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Scrollbar)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Scrollbar)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.ScrollRect",
			new ProximaComponentCommands.PropertyInfo[12]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "content",
					PropertyType = typeof(RectTransform),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).content = (RectTransform)v;
					},
					Getter = (object o) => ((ScrollRect)o).content
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "horizontal",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).horizontal = (bool)v;
					},
					Getter = (object o) => ((ScrollRect)o).horizontal,
					Updater = delegate(object o, ref object v)
					{
						bool horizontal = ((ScrollRect)o).horizontal;
						if (!horizontal.Equals((bool)v))
						{
							v = horizontal;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "vertical",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).vertical = (bool)v;
					},
					Getter = (object o) => ((ScrollRect)o).vertical,
					Updater = delegate(object o, ref object v)
					{
						bool vertical = ((ScrollRect)o).vertical;
						if (!vertical.Equals((bool)v))
						{
							v = vertical;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "movementType",
					PropertyType = typeof(ScrollRect.MovementType),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).movementType = (ScrollRect.MovementType)v;
					},
					Getter = (object o) => ((ScrollRect)o).movementType,
					Updater = delegate(object o, ref object v)
					{
						int movementType = (int)((ScrollRect)o).movementType;
						if (!movementType.Equals((int)v))
						{
							v = movementType;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "elasticity",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).elasticity = (float)v;
					},
					Getter = (object o) => ((ScrollRect)o).elasticity,
					Updater = delegate(object o, ref object v)
					{
						float elasticity = ((ScrollRect)o).elasticity;
						if (!elasticity.Equals((float)v))
						{
							v = elasticity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "inertia",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).inertia = (bool)v;
					},
					Getter = (object o) => ((ScrollRect)o).inertia,
					Updater = delegate(object o, ref object v)
					{
						bool inertia = ((ScrollRect)o).inertia;
						if (!inertia.Equals((bool)v))
						{
							v = inertia;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "decelerationRate",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).decelerationRate = (float)v;
					},
					Getter = (object o) => ((ScrollRect)o).decelerationRate,
					Updater = delegate(object o, ref object v)
					{
						float decelerationRate = ((ScrollRect)o).decelerationRate;
						if (!decelerationRate.Equals((float)v))
						{
							v = decelerationRate;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "scrollSensitivity",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).scrollSensitivity = (float)v;
					},
					Getter = (object o) => ((ScrollRect)o).scrollSensitivity,
					Updater = delegate(object o, ref object v)
					{
						float scrollSensitivity = ((ScrollRect)o).scrollSensitivity;
						if (!scrollSensitivity.Equals((float)v))
						{
							v = scrollSensitivity;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "viewport",
					PropertyType = typeof(RectTransform),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).viewport = (RectTransform)v;
					},
					Getter = (object o) => ((ScrollRect)o).viewport
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "horizontalScrollbar",
					PropertyType = typeof(Scrollbar),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).horizontalScrollbar = (Scrollbar)v;
					},
					Getter = (object o) => ((ScrollRect)o).horizontalScrollbar
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "verticalScrollbar",
					PropertyType = typeof(Scrollbar),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).verticalScrollbar = (Scrollbar)v;
					},
					Getter = (object o) => ((ScrollRect)o).verticalScrollbar
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ScrollRect)o).enabled = (bool)v;
					},
					Getter = (object o) => ((ScrollRect)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((ScrollRect)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.Shadow",
			new ProximaComponentCommands.PropertyInfo[4]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "effectColor",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((Shadow)o).effectColor = (Color)v;
					},
					Getter = (object o) => ((Shadow)o).effectColor,
					Updater = delegate(object o, ref object v)
					{
						Color effectColor = ((Shadow)o).effectColor;
						if (!effectColor.Equals((Color)v))
						{
							v = effectColor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "effectDistance",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((Shadow)o).effectDistance = (Vector2)v;
					},
					Getter = (object o) => ((Shadow)o).effectDistance,
					Updater = delegate(object o, ref object v)
					{
						Vector2 effectDistance = ((Shadow)o).effectDistance;
						if (!effectDistance.Equals((Vector2)v))
						{
							v = effectDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useGraphicAlpha",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Shadow)o).useGraphicAlpha = (bool)v;
					},
					Getter = (object o) => ((Shadow)o).useGraphicAlpha,
					Updater = delegate(object o, ref object v)
					{
						bool useGraphicAlpha = ((Shadow)o).useGraphicAlpha;
						if (!useGraphicAlpha.Equals((bool)v))
						{
							v = useGraphicAlpha;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Shadow)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Shadow)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Shadow)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.SkinnedMeshRenderer",
			new ProximaComponentCommands.PropertyInfo[13]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "bounds",
					PropertyType = typeof(Bounds),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).bounds = (Bounds)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).bounds,
					Updater = delegate(object o, ref object v)
					{
						Bounds bounds = ((SkinnedMeshRenderer)o).bounds;
						if (!bounds.Equals((Bounds)v))
						{
							v = bounds;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "quality",
					PropertyType = typeof(SkinQuality),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).quality = (SkinQuality)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).quality,
					Updater = delegate(object o, ref object v)
					{
						int quality = (int)((SkinnedMeshRenderer)o).quality;
						if (!quality.Equals((int)v))
						{
							v = quality;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "updateWhenOffscreen",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).updateWhenOffscreen = (bool)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).updateWhenOffscreen,
					Updater = delegate(object o, ref object v)
					{
						bool updateWhenOffscreen = ((SkinnedMeshRenderer)o).updateWhenOffscreen;
						if (!updateWhenOffscreen.Equals((bool)v))
						{
							v = updateWhenOffscreen;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMesh",
					PropertyType = typeof(Mesh),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).sharedMesh = (Mesh)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).sharedMesh
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "rootBone",
					PropertyType = typeof(Transform),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).rootBone = (Transform)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).rootBone
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterials",
					PropertyType = typeof(Material[]),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).sharedMaterials = (Material[])v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).sharedMaterials,
					Updater = delegate(object o, ref object v)
					{
						Material[] sharedMaterials = ((SkinnedMeshRenderer)o).sharedMaterials;
						if (sharedMaterials.Length != ((Material[])v).Length)
						{
							v = sharedMaterials;
							return true;
						}
						v = sharedMaterials;
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shadowCastingMode",
					PropertyType = typeof(ShadowCastingMode),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).shadowCastingMode = (ShadowCastingMode)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).shadowCastingMode,
					Updater = delegate(object o, ref object v)
					{
						int shadowCastingMode = (int)((SkinnedMeshRenderer)o).shadowCastingMode;
						if (!shadowCastingMode.Equals((int)v))
						{
							v = shadowCastingMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "receiveShadows",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).receiveShadows = (bool)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).receiveShadows,
					Updater = delegate(object o, ref object v)
					{
						bool receiveShadows = ((SkinnedMeshRenderer)o).receiveShadows;
						if (!receiveShadows.Equals((bool)v))
						{
							v = receiveShadows;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lightProbeUsage",
					PropertyType = typeof(LightProbeUsage),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).lightProbeUsage = (LightProbeUsage)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).lightProbeUsage,
					Updater = delegate(object o, ref object v)
					{
						int lightProbeUsage = (int)((SkinnedMeshRenderer)o).lightProbeUsage;
						if (!lightProbeUsage.Equals((int)v))
						{
							v = lightProbeUsage;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reflectionProbeUsage",
					PropertyType = typeof(ReflectionProbeUsage),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).reflectionProbeUsage = (ReflectionProbeUsage)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).reflectionProbeUsage,
					Updater = delegate(object o, ref object v)
					{
						int reflectionProbeUsage = (int)((SkinnedMeshRenderer)o).reflectionProbeUsage;
						if (!reflectionProbeUsage.Equals((int)v))
						{
							v = reflectionProbeUsage;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "motionVectorGenerationMode",
					PropertyType = typeof(MotionVectorGenerationMode),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).motionVectorGenerationMode = (MotionVectorGenerationMode)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).motionVectorGenerationMode,
					Updater = delegate(object o, ref object v)
					{
						int motionVectorGenerationMode = (int)((SkinnedMeshRenderer)o).motionVectorGenerationMode;
						if (!motionVectorGenerationMode.Equals((int)v))
						{
							v = motionVectorGenerationMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "allowOcclusionWhenDynamic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).allowOcclusionWhenDynamic = (bool)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).allowOcclusionWhenDynamic,
					Updater = delegate(object o, ref object v)
					{
						bool allowOcclusionWhenDynamic = ((SkinnedMeshRenderer)o).allowOcclusionWhenDynamic;
						if (!allowOcclusionWhenDynamic.Equals((bool)v))
						{
							v = allowOcclusionWhenDynamic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SkinnedMeshRenderer)o).enabled = (bool)v;
					},
					Getter = (object o) => ((SkinnedMeshRenderer)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((SkinnedMeshRenderer)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Skybox",
			new ProximaComponentCommands.PropertyInfo[2]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "material",
					PropertyType = typeof(Material),
					Setter = (object o, object v) =>
					{
						((Skybox)o).material = (Material)v;
					},
					Getter = (object o) => ((Skybox)o).material
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Skybox)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Skybox)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Skybox)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.Slider",
			new ProximaComponentCommands.PropertyInfo[13]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "interactable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).interactable = (bool)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).interactable,
					Updater = delegate(object o, ref object v)
					{
						bool interactable = ((UnityEngine.UI.Slider)o).interactable;
						if (!interactable.Equals((bool)v))
						{
							v = interactable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "transition",
					PropertyType = typeof(Selectable.Transition),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).transition = (Selectable.Transition)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).transition,
					Updater = delegate(object o, ref object v)
					{
						int transition = (int)((UnityEngine.UI.Slider)o).transition;
						if (!transition.Equals((int)v))
						{
							v = transition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetGraphic",
					PropertyType = typeof(Graphic),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).targetGraphic = (Graphic)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).targetGraphic
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colors",
					PropertyType = typeof(ColorBlock),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).colors = (ColorBlock)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).colors,
					Updater = delegate(object o, ref object v)
					{
						ColorBlock colors = ((UnityEngine.UI.Slider)o).colors;
						if (!colors.Equals((ColorBlock)v))
						{
							v = colors;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "navigation",
					PropertyType = typeof(Navigation),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).navigation = (Navigation)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).navigation,
					Updater = delegate(object o, ref object v)
					{
						Navigation navigation = ((UnityEngine.UI.Slider)o).navigation;
						if (!navigation.Equals((Navigation)v))
						{
							v = navigation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fillRect",
					PropertyType = typeof(RectTransform),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).fillRect = (RectTransform)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).fillRect
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "handleRect",
					PropertyType = typeof(RectTransform),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).handleRect = (RectTransform)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).handleRect
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "direction",
					PropertyType = typeof(UnityEngine.UI.Slider.Direction),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).direction = (UnityEngine.UI.Slider.Direction)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).direction,
					Updater = delegate(object o, ref object v)
					{
						int direction = (int)((UnityEngine.UI.Slider)o).direction;
						if (!direction.Equals((int)v))
						{
							v = direction;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "minValue",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).minValue = (float)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).minValue,
					Updater = delegate(object o, ref object v)
					{
						float minValue = ((UnityEngine.UI.Slider)o).minValue;
						if (!minValue.Equals((float)v))
						{
							v = minValue;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxValue",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).maxValue = (float)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).maxValue,
					Updater = delegate(object o, ref object v)
					{
						float maxValue = ((UnityEngine.UI.Slider)o).maxValue;
						if (!maxValue.Equals((float)v))
						{
							v = maxValue;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "wholeNumbers",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).wholeNumbers = (bool)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).wholeNumbers,
					Updater = delegate(object o, ref object v)
					{
						bool wholeNumbers = ((UnityEngine.UI.Slider)o).wholeNumbers;
						if (!wholeNumbers.Equals((bool)v))
						{
							v = wholeNumbers;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "value",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).value = (float)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).value,
					Updater = delegate(object o, ref object v)
					{
						float value = ((UnityEngine.UI.Slider)o).value;
						if (!value.Equals((float)v))
						{
							v = value;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Slider)o).enabled = (bool)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Slider)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((UnityEngine.UI.Slider)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.SliderJoint2D",
			new ProximaComponentCommands.PropertyInfo[14]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((SliderJoint2D)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody2D),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).connectedBody = (Rigidbody2D)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureConnectedAnchor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).autoConfigureConnectedAnchor = (bool)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).autoConfigureConnectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureConnectedAnchor = ((SliderJoint2D)o).autoConfigureConnectedAnchor;
						if (!autoConfigureConnectedAnchor.Equals((bool)v))
						{
							v = autoConfigureConnectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).anchor = (Vector2)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 anchor = ((SliderJoint2D)o).anchor;
						if (!anchor.Equals((Vector2)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedAnchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).connectedAnchor = (Vector2)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).connectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 connectedAnchor = ((SliderJoint2D)o).connectedAnchor;
						if (!connectedAnchor.Equals((Vector2)v))
						{
							v = connectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureAngle",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).autoConfigureAngle = (bool)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).autoConfigureAngle,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureAngle = ((SliderJoint2D)o).autoConfigureAngle;
						if (!autoConfigureAngle.Equals((bool)v))
						{
							v = autoConfigureAngle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "angle",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).angle = (float)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).angle,
					Updater = delegate(object o, ref object v)
					{
						float angle = ((SliderJoint2D)o).angle;
						if (!angle.Equals((float)v))
						{
							v = angle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useMotor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).useMotor = (bool)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).useMotor,
					Updater = delegate(object o, ref object v)
					{
						bool useMotor = ((SliderJoint2D)o).useMotor;
						if (!useMotor.Equals((bool)v))
						{
							v = useMotor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "motor",
					PropertyType = typeof(JointMotor2D),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).motor = (JointMotor2D)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).motor,
					Updater = delegate(object o, ref object v)
					{
						JointMotor2D motor = ((SliderJoint2D)o).motor;
						if (!motor.Equals((JointMotor2D)v))
						{
							v = motor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useLimits",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).useLimits = (bool)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).useLimits,
					Updater = delegate(object o, ref object v)
					{
						bool useLimits = ((SliderJoint2D)o).useLimits;
						if (!useLimits.Equals((bool)v))
						{
							v = useLimits;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "limits",
					PropertyType = typeof(JointTranslationLimits2D),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).limits = (JointTranslationLimits2D)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).limits,
					Updater = delegate(object o, ref object v)
					{
						JointTranslationLimits2D limits = ((SliderJoint2D)o).limits;
						if (!limits.Equals((JointTranslationLimits2D)v))
						{
							v = limits;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).breakForce = (float)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((SliderJoint2D)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).breakTorque = (float)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).breakTorque,
					Updater = delegate(object o, ref object v)
					{
						float breakTorque = ((SliderJoint2D)o).breakTorque;
						if (!breakTorque.Equals((float)v))
						{
							v = breakTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SliderJoint2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((SliderJoint2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((SliderJoint2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Rendering.SortingGroup",
			new ProximaComponentCommands.PropertyInfo[3]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingLayerID",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((SortingGroup)o).sortingLayerID = (int)v;
					},
					Getter = (object o) => ((SortingGroup)o).sortingLayerID,
					Updater = delegate(object o, ref object v)
					{
						int sortingLayerID = ((SortingGroup)o).sortingLayerID;
						if (!sortingLayerID.Equals((int)v))
						{
							v = sortingLayerID;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingOrder",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((SortingGroup)o).sortingOrder = (int)v;
					},
					Getter = (object o) => ((SortingGroup)o).sortingOrder,
					Updater = delegate(object o, ref object v)
					{
						int sortingOrder = ((SortingGroup)o).sortingOrder;
						if (!sortingOrder.Equals((int)v))
						{
							v = sortingOrder;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SortingGroup)o).enabled = (bool)v;
					},
					Getter = (object o) => ((SortingGroup)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((SortingGroup)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.SphereCollider",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTrigger",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SphereCollider)o).isTrigger = (bool)v;
					},
					Getter = (object o) => ((SphereCollider)o).isTrigger,
					Updater = delegate(object o, ref object v)
					{
						bool isTrigger = ((SphereCollider)o).isTrigger;
						if (!isTrigger.Equals((bool)v))
						{
							v = isTrigger;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterial",
					PropertyType = typeof(PhysicMaterial),
					Setter = (object o, object v) =>
					{
						((SphereCollider)o).sharedMaterial = (PhysicMaterial)v;
					},
					Getter = (object o) => ((SphereCollider)o).sharedMaterial
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "center",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((SphereCollider)o).center = (Vector3)v;
					},
					Getter = (object o) => ((SphereCollider)o).center,
					Updater = delegate(object o, ref object v)
					{
						Vector3 center = ((SphereCollider)o).center;
						if (!center.Equals((Vector3)v))
						{
							v = center;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "radius",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SphereCollider)o).radius = (float)v;
					},
					Getter = (object o) => ((SphereCollider)o).radius,
					Updater = delegate(object o, ref object v)
					{
						float radius = ((SphereCollider)o).radius;
						if (!radius.Equals((float)v))
						{
							v = radius;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SphereCollider)o).enabled = (bool)v;
					},
					Getter = (object o) => ((SphereCollider)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((SphereCollider)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.SpringJoint",
			new ProximaComponentCommands.PropertyInfo[17]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).connectedBody = (Rigidbody)v;
					},
					Getter = (object o) => ((SpringJoint)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedArticulationBody",
					PropertyType = typeof(ArticulationBody),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).connectedArticulationBody = (ArticulationBody)v;
					},
					Getter = (object o) => ((SpringJoint)o).connectedArticulationBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).anchor = (Vector3)v;
					},
					Getter = (object o) => ((SpringJoint)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector3 anchor = ((SpringJoint)o).anchor;
						if (!anchor.Equals((Vector3)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "axis",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).axis = (Vector3)v;
					},
					Getter = (object o) => ((SpringJoint)o).axis,
					Updater = delegate(object o, ref object v)
					{
						Vector3 axis = ((SpringJoint)o).axis;
						if (!axis.Equals((Vector3)v))
						{
							v = axis;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureConnectedAnchor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).autoConfigureConnectedAnchor = (bool)v;
					},
					Getter = (object o) => ((SpringJoint)o).autoConfigureConnectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureConnectedAnchor = ((SpringJoint)o).autoConfigureConnectedAnchor;
						if (!autoConfigureConnectedAnchor.Equals((bool)v))
						{
							v = autoConfigureConnectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedAnchor",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).connectedAnchor = (Vector3)v;
					},
					Getter = (object o) => ((SpringJoint)o).connectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						Vector3 connectedAnchor = ((SpringJoint)o).connectedAnchor;
						if (!connectedAnchor.Equals((Vector3)v))
						{
							v = connectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spring",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).spring = (float)v;
					},
					Getter = (object o) => ((SpringJoint)o).spring,
					Updater = delegate(object o, ref object v)
					{
						float spring = ((SpringJoint)o).spring;
						if (!spring.Equals((float)v))
						{
							v = spring;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "damper",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).damper = (float)v;
					},
					Getter = (object o) => ((SpringJoint)o).damper,
					Updater = delegate(object o, ref object v)
					{
						float damper = ((SpringJoint)o).damper;
						if (!damper.Equals((float)v))
						{
							v = damper;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "minDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).minDistance = (float)v;
					},
					Getter = (object o) => ((SpringJoint)o).minDistance,
					Updater = delegate(object o, ref object v)
					{
						float minDistance = ((SpringJoint)o).minDistance;
						if (!minDistance.Equals((float)v))
						{
							v = minDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).maxDistance = (float)v;
					},
					Getter = (object o) => ((SpringJoint)o).maxDistance,
					Updater = delegate(object o, ref object v)
					{
						float maxDistance = ((SpringJoint)o).maxDistance;
						if (!maxDistance.Equals((float)v))
						{
							v = maxDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "tolerance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).tolerance = (float)v;
					},
					Getter = (object o) => ((SpringJoint)o).tolerance,
					Updater = delegate(object o, ref object v)
					{
						float tolerance = ((SpringJoint)o).tolerance;
						if (!tolerance.Equals((float)v))
						{
							v = tolerance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).breakForce = (float)v;
					},
					Getter = (object o) => ((SpringJoint)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((SpringJoint)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).breakTorque = (float)v;
					},
					Getter = (object o) => ((SpringJoint)o).breakTorque,
					Updater = delegate(object o, ref object v)
					{
						float breakTorque = ((SpringJoint)o).breakTorque;
						if (!breakTorque.Equals((float)v))
						{
							v = breakTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((SpringJoint)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((SpringJoint)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enablePreprocessing",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).enablePreprocessing = (bool)v;
					},
					Getter = (object o) => ((SpringJoint)o).enablePreprocessing,
					Updater = delegate(object o, ref object v)
					{
						bool enablePreprocessing = ((SpringJoint)o).enablePreprocessing;
						if (!enablePreprocessing.Equals((bool)v))
						{
							v = enablePreprocessing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "massScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).massScale = (float)v;
					},
					Getter = (object o) => ((SpringJoint)o).massScale,
					Updater = delegate(object o, ref object v)
					{
						float massScale = ((SpringJoint)o).massScale;
						if (!massScale.Equals((float)v))
						{
							v = massScale;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedMassScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint)o).connectedMassScale = (float)v;
					},
					Getter = (object o) => ((SpringJoint)o).connectedMassScale,
					Updater = delegate(object o, ref object v)
					{
						float connectedMassScale = ((SpringJoint)o).connectedMassScale;
						if (!connectedMassScale.Equals((float)v))
						{
							v = connectedMassScale;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.SpringJoint2D",
			new ProximaComponentCommands.PropertyInfo[11]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpringJoint2D)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((SpringJoint2D)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((SpringJoint2D)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody2D),
					Setter = (object o, object v) =>
					{
						((SpringJoint2D)o).connectedBody = (Rigidbody2D)v;
					},
					Getter = (object o) => ((SpringJoint2D)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureConnectedAnchor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpringJoint2D)o).autoConfigureConnectedAnchor = (bool)v;
					},
					Getter = (object o) => ((SpringJoint2D)o).autoConfigureConnectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureConnectedAnchor = ((SpringJoint2D)o).autoConfigureConnectedAnchor;
						if (!autoConfigureConnectedAnchor.Equals((bool)v))
						{
							v = autoConfigureConnectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((SpringJoint2D)o).anchor = (Vector2)v;
					},
					Getter = (object o) => ((SpringJoint2D)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 anchor = ((SpringJoint2D)o).anchor;
						if (!anchor.Equals((Vector2)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedAnchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((SpringJoint2D)o).connectedAnchor = (Vector2)v;
					},
					Getter = (object o) => ((SpringJoint2D)o).connectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 connectedAnchor = ((SpringJoint2D)o).connectedAnchor;
						if (!connectedAnchor.Equals((Vector2)v))
						{
							v = connectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureDistance",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpringJoint2D)o).autoConfigureDistance = (bool)v;
					},
					Getter = (object o) => ((SpringJoint2D)o).autoConfigureDistance,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureDistance = ((SpringJoint2D)o).autoConfigureDistance;
						if (!autoConfigureDistance.Equals((bool)v))
						{
							v = autoConfigureDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "distance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint2D)o).distance = (float)v;
					},
					Getter = (object o) => ((SpringJoint2D)o).distance,
					Updater = delegate(object o, ref object v)
					{
						float distance = ((SpringJoint2D)o).distance;
						if (!distance.Equals((float)v))
						{
							v = distance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "dampingRatio",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint2D)o).dampingRatio = (float)v;
					},
					Getter = (object o) => ((SpringJoint2D)o).dampingRatio,
					Updater = delegate(object o, ref object v)
					{
						float dampingRatio = ((SpringJoint2D)o).dampingRatio;
						if (!dampingRatio.Equals((float)v))
						{
							v = dampingRatio;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "frequency",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint2D)o).frequency = (float)v;
					},
					Getter = (object o) => ((SpringJoint2D)o).frequency,
					Updater = delegate(object o, ref object v)
					{
						float frequency = ((SpringJoint2D)o).frequency;
						if (!frequency.Equals((float)v))
						{
							v = frequency;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpringJoint2D)o).breakForce = (float)v;
					},
					Getter = (object o) => ((SpringJoint2D)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((SpringJoint2D)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpringJoint2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((SpringJoint2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((SpringJoint2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.SpriteMask",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sprite",
					PropertyType = typeof(Sprite),
					Setter = (object o, object v) =>
					{
						((SpriteMask)o).sprite = (Sprite)v;
					},
					Getter = (object o) => ((SpriteMask)o).sprite
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "alphaCutoff",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SpriteMask)o).alphaCutoff = (float)v;
					},
					Getter = (object o) => ((SpriteMask)o).alphaCutoff,
					Updater = delegate(object o, ref object v)
					{
						float alphaCutoff = ((SpriteMask)o).alphaCutoff;
						if (!alphaCutoff.Equals((float)v))
						{
							v = alphaCutoff;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isCustomRangeActive",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpriteMask)o).isCustomRangeActive = (bool)v;
					},
					Getter = (object o) => ((SpriteMask)o).isCustomRangeActive,
					Updater = delegate(object o, ref object v)
					{
						bool isCustomRangeActive = ((SpriteMask)o).isCustomRangeActive;
						if (!isCustomRangeActive.Equals((bool)v))
						{
							v = isCustomRangeActive;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "frontSortingOrder",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((SpriteMask)o).frontSortingOrder = (int)v;
					},
					Getter = (object o) => ((SpriteMask)o).frontSortingOrder,
					Updater = delegate(object o, ref object v)
					{
						int frontSortingOrder = ((SpriteMask)o).frontSortingOrder;
						if (!frontSortingOrder.Equals((int)v))
						{
							v = frontSortingOrder;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpriteMask)o).enabled = (bool)v;
					},
					Getter = (object o) => ((SpriteMask)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((SpriteMask)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.SpriteRenderer",
			new ProximaComponentCommands.PropertyInfo[11]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sprite",
					PropertyType = typeof(Sprite),
					Setter = (object o, object v) =>
					{
						((SpriteRenderer)o).sprite = (Sprite)v;
					},
					Getter = (object o) => ((SpriteRenderer)o).sprite
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "color",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((SpriteRenderer)o).color = (Color)v;
					},
					Getter = (object o) => ((SpriteRenderer)o).color,
					Updater = delegate(object o, ref object v)
					{
						Color color = ((SpriteRenderer)o).color;
						if (!color.Equals((Color)v))
						{
							v = color;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "flipX",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpriteRenderer)o).flipX = (bool)v;
					},
					Getter = (object o) => ((SpriteRenderer)o).flipX,
					Updater = delegate(object o, ref object v)
					{
						bool flipX = ((SpriteRenderer)o).flipX;
						if (!flipX.Equals((bool)v))
						{
							v = flipX;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "flipY",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpriteRenderer)o).flipY = (bool)v;
					},
					Getter = (object o) => ((SpriteRenderer)o).flipY,
					Updater = delegate(object o, ref object v)
					{
						bool flipY = ((SpriteRenderer)o).flipY;
						if (!flipY.Equals((bool)v))
						{
							v = flipY;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "drawMode",
					PropertyType = typeof(SpriteDrawMode),
					Setter = (object o, object v) =>
					{
						((SpriteRenderer)o).drawMode = (SpriteDrawMode)v;
					},
					Getter = (object o) => ((SpriteRenderer)o).drawMode,
					Updater = delegate(object o, ref object v)
					{
						int drawMode = (int)((SpriteRenderer)o).drawMode;
						if (!drawMode.Equals((int)v))
						{
							v = drawMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maskInteraction",
					PropertyType = typeof(SpriteMaskInteraction),
					Setter = (object o, object v) =>
					{
						((SpriteRenderer)o).maskInteraction = (SpriteMaskInteraction)v;
					},
					Getter = (object o) => ((SpriteRenderer)o).maskInteraction,
					Updater = delegate(object o, ref object v)
					{
						int maskInteraction = (int)((SpriteRenderer)o).maskInteraction;
						if (!maskInteraction.Equals((int)v))
						{
							v = maskInteraction;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spriteSortPoint",
					PropertyType = typeof(SpriteSortPoint),
					Setter = (object o, object v) =>
					{
						((SpriteRenderer)o).spriteSortPoint = (SpriteSortPoint)v;
					},
					Getter = (object o) => ((SpriteRenderer)o).spriteSortPoint,
					Updater = delegate(object o, ref object v)
					{
						int spriteSortPoint = (int)((SpriteRenderer)o).spriteSortPoint;
						if (!spriteSortPoint.Equals((int)v))
						{
							v = spriteSortPoint;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterials",
					PropertyType = typeof(Material[]),
					Setter = (object o, object v) =>
					{
						((SpriteRenderer)o).sharedMaterials = (Material[])v;
					},
					Getter = (object o) => ((SpriteRenderer)o).sharedMaterials,
					Updater = delegate(object o, ref object v)
					{
						Material[] sharedMaterials = ((SpriteRenderer)o).sharedMaterials;
						if (sharedMaterials.Length != ((Material[])v).Length)
						{
							v = sharedMaterials;
							return true;
						}
						v = sharedMaterials;
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingLayerID",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((SpriteRenderer)o).sortingLayerID = (int)v;
					},
					Getter = (object o) => ((SpriteRenderer)o).sortingLayerID,
					Updater = delegate(object o, ref object v)
					{
						int sortingLayerID = ((SpriteRenderer)o).sortingLayerID;
						if (!sortingLayerID.Equals((int)v))
						{
							v = sortingLayerID;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingOrder",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((SpriteRenderer)o).sortingOrder = (int)v;
					},
					Getter = (object o) => ((SpriteRenderer)o).sortingOrder,
					Updater = delegate(object o, ref object v)
					{
						int sortingOrder = ((SpriteRenderer)o).sortingOrder;
						if (!sortingOrder.Equals((int)v))
						{
							v = sortingOrder;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpriteRenderer)o).enabled = (bool)v;
					},
					Getter = (object o) => ((SpriteRenderer)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((SpriteRenderer)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.U2D.SpriteShapeRenderer",
			new ProximaComponentCommands.PropertyInfo[6]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "color",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((SpriteShapeRenderer)o).color = (Color)v;
					},
					Getter = (object o) => ((SpriteShapeRenderer)o).color,
					Updater = delegate(object o, ref object v)
					{
						Color color = ((SpriteShapeRenderer)o).color;
						if (!color.Equals((Color)v))
						{
							v = color;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maskInteraction",
					PropertyType = typeof(SpriteMaskInteraction),
					Setter = (object o, object v) =>
					{
						((SpriteShapeRenderer)o).maskInteraction = (SpriteMaskInteraction)v;
					},
					Getter = (object o) => ((SpriteShapeRenderer)o).maskInteraction,
					Updater = delegate(object o, ref object v)
					{
						int maskInteraction = (int)((SpriteShapeRenderer)o).maskInteraction;
						if (!maskInteraction.Equals((int)v))
						{
							v = maskInteraction;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterials",
					PropertyType = typeof(Material[]),
					Setter = (object o, object v) =>
					{
						((SpriteShapeRenderer)o).sharedMaterials = (Material[])v;
					},
					Getter = (object o) => ((SpriteShapeRenderer)o).sharedMaterials,
					Updater = delegate(object o, ref object v)
					{
						Material[] sharedMaterials = ((SpriteShapeRenderer)o).sharedMaterials;
						if (sharedMaterials.Length != ((Material[])v).Length)
						{
							v = sharedMaterials;
							return true;
						}
						v = sharedMaterials;
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingLayerID",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((SpriteShapeRenderer)o).sortingLayerID = (int)v;
					},
					Getter = (object o) => ((SpriteShapeRenderer)o).sortingLayerID,
					Updater = delegate(object o, ref object v)
					{
						int sortingLayerID = ((SpriteShapeRenderer)o).sortingLayerID;
						if (!sortingLayerID.Equals((int)v))
						{
							v = sortingLayerID;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingOrder",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((SpriteShapeRenderer)o).sortingOrder = (int)v;
					},
					Getter = (object o) => ((SpriteShapeRenderer)o).sortingOrder,
					Updater = delegate(object o, ref object v)
					{
						int sortingOrder = ((SpriteShapeRenderer)o).sortingOrder;
						if (!sortingOrder.Equals((int)v))
						{
							v = sortingOrder;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SpriteShapeRenderer)o).enabled = (bool)v;
					},
					Getter = (object o) => ((SpriteShapeRenderer)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((SpriteShapeRenderer)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.EventSystems.StandaloneInputModule",
			new ProximaComponentCommands.PropertyInfo[7]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "horizontalAxis",
					PropertyType = typeof(string),
					Setter = (object o, object v) =>
					{
						((StandaloneInputModule)o).horizontalAxis = (string)v;
					},
					Getter = (object o) => ((StandaloneInputModule)o).horizontalAxis
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "verticalAxis",
					PropertyType = typeof(string),
					Setter = (object o, object v) =>
					{
						((StandaloneInputModule)o).verticalAxis = (string)v;
					},
					Getter = (object o) => ((StandaloneInputModule)o).verticalAxis
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "submitButton",
					PropertyType = typeof(string),
					Setter = (object o, object v) =>
					{
						((StandaloneInputModule)o).submitButton = (string)v;
					},
					Getter = (object o) => ((StandaloneInputModule)o).submitButton
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "cancelButton",
					PropertyType = typeof(string),
					Setter = (object o, object v) =>
					{
						((StandaloneInputModule)o).cancelButton = (string)v;
					},
					Getter = (object o) => ((StandaloneInputModule)o).cancelButton
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "inputActionsPerSecond",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((StandaloneInputModule)o).inputActionsPerSecond = (float)v;
					},
					Getter = (object o) => ((StandaloneInputModule)o).inputActionsPerSecond,
					Updater = delegate(object o, ref object v)
					{
						float inputActionsPerSecond = ((StandaloneInputModule)o).inputActionsPerSecond;
						if (!inputActionsPerSecond.Equals((float)v))
						{
							v = inputActionsPerSecond;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "repeatDelay",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((StandaloneInputModule)o).repeatDelay = (float)v;
					},
					Getter = (object o) => ((StandaloneInputModule)o).repeatDelay,
					Updater = delegate(object o, ref object v)
					{
						float repeatDelay = ((StandaloneInputModule)o).repeatDelay;
						if (!repeatDelay.Equals((float)v))
						{
							v = repeatDelay;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((StandaloneInputModule)o).enabled = (bool)v;
					},
					Getter = (object o) => ((StandaloneInputModule)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((StandaloneInputModule)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.StreamingController",
			new ProximaComponentCommands.PropertyInfo[2]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "streamingMipmapBias",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((StreamingController)o).streamingMipmapBias = (float)v;
					},
					Getter = (object o) => ((StreamingController)o).streamingMipmapBias,
					Updater = delegate(object o, ref object v)
					{
						float streamingMipmapBias = ((StreamingController)o).streamingMipmapBias;
						if (!streamingMipmapBias.Equals((float)v))
						{
							v = streamingMipmapBias;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((StreamingController)o).enabled = (bool)v;
					},
					Getter = (object o) => ((StreamingController)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((StreamingController)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.SurfaceEffector2D",
			new ProximaComponentCommands.PropertyInfo[9]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useColliderMask",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SurfaceEffector2D)o).useColliderMask = (bool)v;
					},
					Getter = (object o) => ((SurfaceEffector2D)o).useColliderMask,
					Updater = delegate(object o, ref object v)
					{
						bool useColliderMask = ((SurfaceEffector2D)o).useColliderMask;
						if (!useColliderMask.Equals((bool)v))
						{
							v = useColliderMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colliderMask",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((SurfaceEffector2D)o).colliderMask = (int)v;
					},
					Getter = (object o) => ((SurfaceEffector2D)o).colliderMask,
					Updater = delegate(object o, ref object v)
					{
						int colliderMask = ((SurfaceEffector2D)o).colliderMask;
						if (!colliderMask.Equals((int)v))
						{
							v = colliderMask;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "speed",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SurfaceEffector2D)o).speed = (float)v;
					},
					Getter = (object o) => ((SurfaceEffector2D)o).speed,
					Updater = delegate(object o, ref object v)
					{
						float speed = ((SurfaceEffector2D)o).speed;
						if (!speed.Equals((float)v))
						{
							v = speed;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "speedVariation",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SurfaceEffector2D)o).speedVariation = (float)v;
					},
					Getter = (object o) => ((SurfaceEffector2D)o).speedVariation,
					Updater = delegate(object o, ref object v)
					{
						float speedVariation = ((SurfaceEffector2D)o).speedVariation;
						if (!speedVariation.Equals((float)v))
						{
							v = speedVariation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "forceScale",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((SurfaceEffector2D)o).forceScale = (float)v;
					},
					Getter = (object o) => ((SurfaceEffector2D)o).forceScale,
					Updater = delegate(object o, ref object v)
					{
						float forceScale = ((SurfaceEffector2D)o).forceScale;
						if (!forceScale.Equals((float)v))
						{
							v = forceScale;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useContactForce",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SurfaceEffector2D)o).useContactForce = (bool)v;
					},
					Getter = (object o) => ((SurfaceEffector2D)o).useContactForce,
					Updater = delegate(object o, ref object v)
					{
						bool useContactForce = ((SurfaceEffector2D)o).useContactForce;
						if (!useContactForce.Equals((bool)v))
						{
							v = useContactForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useFriction",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SurfaceEffector2D)o).useFriction = (bool)v;
					},
					Getter = (object o) => ((SurfaceEffector2D)o).useFriction,
					Updater = delegate(object o, ref object v)
					{
						bool useFriction = ((SurfaceEffector2D)o).useFriction;
						if (!useFriction.Equals((bool)v))
						{
							v = useFriction;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useBounce",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SurfaceEffector2D)o).useBounce = (bool)v;
					},
					Getter = (object o) => ((SurfaceEffector2D)o).useBounce,
					Updater = delegate(object o, ref object v)
					{
						bool useBounce = ((SurfaceEffector2D)o).useBounce;
						if (!useBounce.Equals((bool)v))
						{
							v = useBounce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((SurfaceEffector2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((SurfaceEffector2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((SurfaceEffector2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.TargetJoint2D",
			new ProximaComponentCommands.PropertyInfo[8]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((TargetJoint2D)o).anchor = (Vector2)v;
					},
					Getter = (object o) => ((TargetJoint2D)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 anchor = ((TargetJoint2D)o).anchor;
						if (!anchor.Equals((Vector2)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "target",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((TargetJoint2D)o).target = (Vector2)v;
					},
					Getter = (object o) => ((TargetJoint2D)o).target,
					Updater = delegate(object o, ref object v)
					{
						Vector2 target = ((TargetJoint2D)o).target;
						if (!target.Equals((Vector2)v))
						{
							v = target;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureTarget",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TargetJoint2D)o).autoConfigureTarget = (bool)v;
					},
					Getter = (object o) => ((TargetJoint2D)o).autoConfigureTarget,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureTarget = ((TargetJoint2D)o).autoConfigureTarget;
						if (!autoConfigureTarget.Equals((bool)v))
						{
							v = autoConfigureTarget;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maxForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TargetJoint2D)o).maxForce = (float)v;
					},
					Getter = (object o) => ((TargetJoint2D)o).maxForce,
					Updater = delegate(object o, ref object v)
					{
						float maxForce = ((TargetJoint2D)o).maxForce;
						if (!maxForce.Equals((float)v))
						{
							v = maxForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "dampingRatio",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TargetJoint2D)o).dampingRatio = (float)v;
					},
					Getter = (object o) => ((TargetJoint2D)o).dampingRatio,
					Updater = delegate(object o, ref object v)
					{
						float dampingRatio = ((TargetJoint2D)o).dampingRatio;
						if (!dampingRatio.Equals((float)v))
						{
							v = dampingRatio;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "frequency",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TargetJoint2D)o).frequency = (float)v;
					},
					Getter = (object o) => ((TargetJoint2D)o).frequency,
					Updater = delegate(object o, ref object v)
					{
						float frequency = ((TargetJoint2D)o).frequency;
						if (!frequency.Equals((float)v))
						{
							v = frequency;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TargetJoint2D)o).breakForce = (float)v;
					},
					Getter = (object o) => ((TargetJoint2D)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((TargetJoint2D)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TargetJoint2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((TargetJoint2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((TargetJoint2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.Text",
			new ProximaComponentCommands.PropertyInfo[16]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "text",
					PropertyType = typeof(string),
					Setter = (object o, object v) =>
					{
						((Text)o).text = (string)v;
					},
					Getter = (object o) => ((Text)o).text
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "font",
					PropertyType = typeof(Font),
					Setter = (object o, object v) =>
					{
						((Text)o).font = (Font)v;
					},
					Getter = (object o) => ((Text)o).font
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fontStyle",
					PropertyType = typeof(FontStyle),
					Setter = (object o, object v) =>
					{
						((Text)o).fontStyle = (FontStyle)v;
					},
					Getter = (object o) => ((Text)o).fontStyle,
					Updater = delegate(object o, ref object v)
					{
						int fontStyle = (int)((Text)o).fontStyle;
						if (!fontStyle.Equals((int)v))
						{
							v = fontStyle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fontSize",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((Text)o).fontSize = (int)v;
					},
					Getter = (object o) => ((Text)o).fontSize,
					Updater = delegate(object o, ref object v)
					{
						int fontSize = ((Text)o).fontSize;
						if (!fontSize.Equals((int)v))
						{
							v = fontSize;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lineSpacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((Text)o).lineSpacing = (float)v;
					},
					Getter = (object o) => ((Text)o).lineSpacing,
					Updater = delegate(object o, ref object v)
					{
						float lineSpacing = ((Text)o).lineSpacing;
						if (!lineSpacing.Equals((float)v))
						{
							v = lineSpacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "supportRichText",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Text)o).supportRichText = (bool)v;
					},
					Getter = (object o) => ((Text)o).supportRichText,
					Updater = delegate(object o, ref object v)
					{
						bool supportRichText = ((Text)o).supportRichText;
						if (!supportRichText.Equals((bool)v))
						{
							v = supportRichText;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "alignment",
					PropertyType = typeof(TextAnchor),
					Setter = (object o, object v) =>
					{
						((Text)o).alignment = (TextAnchor)v;
					},
					Getter = (object o) => ((Text)o).alignment,
					Updater = delegate(object o, ref object v)
					{
						int alignment = (int)((Text)o).alignment;
						if (!alignment.Equals((int)v))
						{
							v = alignment;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "alignByGeometry",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Text)o).alignByGeometry = (bool)v;
					},
					Getter = (object o) => ((Text)o).alignByGeometry,
					Updater = delegate(object o, ref object v)
					{
						bool alignByGeometry = ((Text)o).alignByGeometry;
						if (!alignByGeometry.Equals((bool)v))
						{
							v = alignByGeometry;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "horizontalOverflow",
					PropertyType = typeof(HorizontalWrapMode),
					Setter = (object o, object v) =>
					{
						((Text)o).horizontalOverflow = (HorizontalWrapMode)v;
					},
					Getter = (object o) => ((Text)o).horizontalOverflow,
					Updater = delegate(object o, ref object v)
					{
						int horizontalOverflow = (int)((Text)o).horizontalOverflow;
						if (!horizontalOverflow.Equals((int)v))
						{
							v = horizontalOverflow;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "verticalOverflow",
					PropertyType = typeof(VerticalWrapMode),
					Setter = (object o, object v) =>
					{
						((Text)o).verticalOverflow = (VerticalWrapMode)v;
					},
					Getter = (object o) => ((Text)o).verticalOverflow,
					Updater = delegate(object o, ref object v)
					{
						int verticalOverflow = (int)((Text)o).verticalOverflow;
						if (!verticalOverflow.Equals((int)v))
						{
							v = verticalOverflow;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "resizeTextForBestFit",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Text)o).resizeTextForBestFit = (bool)v;
					},
					Getter = (object o) => ((Text)o).resizeTextForBestFit,
					Updater = delegate(object o, ref object v)
					{
						bool resizeTextForBestFit = ((Text)o).resizeTextForBestFit;
						if (!resizeTextForBestFit.Equals((bool)v))
						{
							v = resizeTextForBestFit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "color",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((Text)o).color = (Color)v;
					},
					Getter = (object o) => ((Text)o).color,
					Updater = delegate(object o, ref object v)
					{
						Color color = ((Text)o).color;
						if (!color.Equals((Color)v))
						{
							v = color;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "raycastTarget",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Text)o).raycastTarget = (bool)v;
					},
					Getter = (object o) => ((Text)o).raycastTarget,
					Updater = delegate(object o, ref object v)
					{
						bool raycastTarget = ((Text)o).raycastTarget;
						if (!raycastTarget.Equals((bool)v))
						{
							v = raycastTarget;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "raycastPadding",
					PropertyType = typeof(Vector4),
					Setter = (object o, object v) =>
					{
						((Text)o).raycastPadding = (Vector4)v;
					},
					Getter = (object o) => ((Text)o).raycastPadding,
					Updater = delegate(object o, ref object v)
					{
						Vector4 raycastPadding = ((Text)o).raycastPadding;
						if (!raycastPadding.Equals((Vector4)v))
						{
							v = raycastPadding;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "maskable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Text)o).maskable = (bool)v;
					},
					Getter = (object o) => ((Text)o).maskable,
					Updater = delegate(object o, ref object v)
					{
						bool maskable = ((Text)o).maskable;
						if (!maskable.Equals((bool)v))
						{
							v = maskable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((Text)o).enabled = (bool)v;
					},
					Getter = (object o) => ((Text)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((Text)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"TMPro.TextContainer",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchorPosition",
					PropertyType = typeof(TextContainerAnchors),
					Setter = (object o, object v) =>
					{
						((TextContainer)o).anchorPosition = (TextContainerAnchors)v;
					},
					Getter = (object o) => ((TextContainer)o).anchorPosition,
					Updater = delegate(object o, ref object v)
					{
						int anchorPosition = (int)((TextContainer)o).anchorPosition;
						if (!anchorPosition.Equals((int)v))
						{
							v = anchorPosition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "width",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextContainer)o).width = (float)v;
					},
					Getter = (object o) => ((TextContainer)o).width,
					Updater = delegate(object o, ref object v)
					{
						float width = ((TextContainer)o).width;
						if (!width.Equals((float)v))
						{
							v = width;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "height",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextContainer)o).height = (float)v;
					},
					Getter = (object o) => ((TextContainer)o).height,
					Updater = delegate(object o, ref object v)
					{
						float height = ((TextContainer)o).height;
						if (!height.Equals((float)v))
						{
							v = height;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "margins",
					PropertyType = typeof(Vector4),
					Setter = (object o, object v) =>
					{
						((TextContainer)o).margins = (Vector4)v;
					},
					Getter = (object o) => ((TextContainer)o).margins,
					Updater = delegate(object o, ref object v)
					{
						Vector4 margins = ((TextContainer)o).margins;
						if (!margins.Equals((Vector4)v))
						{
							v = margins;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextContainer)o).enabled = (bool)v;
					},
					Getter = (object o) => ((TextContainer)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((TextContainer)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.TextMesh",
			new ProximaComponentCommands.PropertyInfo[12]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "text",
					PropertyType = typeof(string),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).text = (string)v;
					},
					Getter = (object o) => ((TextMesh)o).text
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "offsetZ",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).offsetZ = (float)v;
					},
					Getter = (object o) => ((TextMesh)o).offsetZ,
					Updater = delegate(object o, ref object v)
					{
						float offsetZ = ((TextMesh)o).offsetZ;
						if (!offsetZ.Equals((float)v))
						{
							v = offsetZ;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "characterSize",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).characterSize = (float)v;
					},
					Getter = (object o) => ((TextMesh)o).characterSize,
					Updater = delegate(object o, ref object v)
					{
						float characterSize = ((TextMesh)o).characterSize;
						if (!characterSize.Equals((float)v))
						{
							v = characterSize;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lineSpacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).lineSpacing = (float)v;
					},
					Getter = (object o) => ((TextMesh)o).lineSpacing,
					Updater = delegate(object o, ref object v)
					{
						float lineSpacing = ((TextMesh)o).lineSpacing;
						if (!lineSpacing.Equals((float)v))
						{
							v = lineSpacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(TextAnchor),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).anchor = (TextAnchor)v;
					},
					Getter = (object o) => ((TextMesh)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						int anchor = (int)((TextMesh)o).anchor;
						if (!anchor.Equals((int)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "alignment",
					PropertyType = typeof(TextAlignment),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).alignment = (TextAlignment)v;
					},
					Getter = (object o) => ((TextMesh)o).alignment,
					Updater = delegate(object o, ref object v)
					{
						int alignment = (int)((TextMesh)o).alignment;
						if (!alignment.Equals((int)v))
						{
							v = alignment;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "tabSize",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).tabSize = (float)v;
					},
					Getter = (object o) => ((TextMesh)o).tabSize,
					Updater = delegate(object o, ref object v)
					{
						float tabSize = ((TextMesh)o).tabSize;
						if (!tabSize.Equals((float)v))
						{
							v = tabSize;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fontSize",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).fontSize = (int)v;
					},
					Getter = (object o) => ((TextMesh)o).fontSize,
					Updater = delegate(object o, ref object v)
					{
						int fontSize = ((TextMesh)o).fontSize;
						if (!fontSize.Equals((int)v))
						{
							v = fontSize;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fontStyle",
					PropertyType = typeof(FontStyle),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).fontStyle = (FontStyle)v;
					},
					Getter = (object o) => ((TextMesh)o).fontStyle,
					Updater = delegate(object o, ref object v)
					{
						int fontStyle = (int)((TextMesh)o).fontStyle;
						if (!fontStyle.Equals((int)v))
						{
							v = fontStyle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "richText",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).richText = (bool)v;
					},
					Getter = (object o) => ((TextMesh)o).richText,
					Updater = delegate(object o, ref object v)
					{
						bool richText = ((TextMesh)o).richText;
						if (!richText.Equals((bool)v))
						{
							v = richText;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "font",
					PropertyType = typeof(Font),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).font = (Font)v;
					},
					Getter = (object o) => ((TextMesh)o).font
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "color",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((TextMesh)o).color = (Color)v;
					},
					Getter = (object o) => ((TextMesh)o).color,
					Updater = delegate(object o, ref object v)
					{
						Color color = ((TextMesh)o).color;
						if (!color.Equals((Color)v))
						{
							v = color;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"TMPro.TextMeshPro",
			new ProximaComponentCommands.PropertyInfo[32]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "text",
					PropertyType = typeof(string),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).text = (string)v;
					},
					Getter = (object o) => ((TextMeshPro)o).text
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "font",
					PropertyType = typeof(TMP_FontAsset),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).font = (TMP_FontAsset)v;
					},
					Getter = (object o) => ((TextMeshPro)o).font
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fontStyle",
					PropertyType = typeof(FontStyles),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).fontStyle = (FontStyles)v;
					},
					Getter = (object o) => ((TextMeshPro)o).fontStyle,
					Updater = delegate(object o, ref object v)
					{
						int fontStyle = (int)((TextMeshPro)o).fontStyle;
						if (!fontStyle.Equals((int)v))
						{
							v = fontStyle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fontSize",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).fontSize = (float)v;
					},
					Getter = (object o) => ((TextMeshPro)o).fontSize,
					Updater = delegate(object o, ref object v)
					{
						float fontSize = ((TextMeshPro)o).fontSize;
						if (!fontSize.Equals((float)v))
						{
							v = fontSize;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoSizeTextContainer",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).autoSizeTextContainer = (bool)v;
					},
					Getter = (object o) => ((TextMeshPro)o).autoSizeTextContainer,
					Updater = delegate(object o, ref object v)
					{
						bool autoSizeTextContainer = ((TextMeshPro)o).autoSizeTextContainer;
						if (!autoSizeTextContainer.Equals((bool)v))
						{
							v = autoSizeTextContainer;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "color",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).color = (Color)v;
					},
					Getter = (object o) => ((TextMeshPro)o).color,
					Updater = delegate(object o, ref object v)
					{
						Color color = ((TextMeshPro)o).color;
						if (!color.Equals((Color)v))
						{
							v = color;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colorGradientPreset",
					PropertyType = typeof(TMP_ColorGradient),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).colorGradientPreset = (TMP_ColorGradient)v;
					},
					Getter = (object o) => ((TextMeshPro)o).colorGradientPreset
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colorGradient",
					PropertyType = typeof(VertexGradient),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).colorGradient = (VertexGradient)v;
					},
					Getter = (object o) => ((TextMeshPro)o).colorGradient,
					Updater = delegate(object o, ref object v)
					{
						VertexGradient colorGradient = ((TextMeshPro)o).colorGradient;
						if (!colorGradient.Equals((VertexGradient)v))
						{
							v = colorGradient;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "overrideColorTags",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).overrideColorTags = (bool)v;
					},
					Getter = (object o) => ((TextMeshPro)o).overrideColorTags,
					Updater = delegate(object o, ref object v)
					{
						bool overrideColorTags = ((TextMeshPro)o).overrideColorTags;
						if (!overrideColorTags.Equals((bool)v))
						{
							v = overrideColorTags;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "characterSpacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).characterSpacing = (float)v;
					},
					Getter = (object o) => ((TextMeshPro)o).characterSpacing,
					Updater = delegate(object o, ref object v)
					{
						float characterSpacing = ((TextMeshPro)o).characterSpacing;
						if (!characterSpacing.Equals((float)v))
						{
							v = characterSpacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "wordSpacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).wordSpacing = (float)v;
					},
					Getter = (object o) => ((TextMeshPro)o).wordSpacing,
					Updater = delegate(object o, ref object v)
					{
						float wordSpacing = ((TextMeshPro)o).wordSpacing;
						if (!wordSpacing.Equals((float)v))
						{
							v = wordSpacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lineSpacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).lineSpacing = (float)v;
					},
					Getter = (object o) => ((TextMeshPro)o).lineSpacing,
					Updater = delegate(object o, ref object v)
					{
						float lineSpacing = ((TextMeshPro)o).lineSpacing;
						if (!lineSpacing.Equals((float)v))
						{
							v = lineSpacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "paragraphSpacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).paragraphSpacing = (float)v;
					},
					Getter = (object o) => ((TextMeshPro)o).paragraphSpacing,
					Updater = delegate(object o, ref object v)
					{
						float paragraphSpacing = ((TextMeshPro)o).paragraphSpacing;
						if (!paragraphSpacing.Equals((float)v))
						{
							v = paragraphSpacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "alignment",
					PropertyType = typeof(TextAlignmentOptions),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).alignment = (TextAlignmentOptions)v;
					},
					Getter = (object o) => ((TextMeshPro)o).alignment,
					Updater = delegate(object o, ref object v)
					{
						int alignment = (int)((TextMeshPro)o).alignment;
						if (!alignment.Equals((int)v))
						{
							v = alignment;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableWordWrapping",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).enableWordWrapping = (bool)v;
					},
					Getter = (object o) => ((TextMeshPro)o).enableWordWrapping,
					Updater = delegate(object o, ref object v)
					{
						bool enableWordWrapping = ((TextMeshPro)o).enableWordWrapping;
						if (!enableWordWrapping.Equals((bool)v))
						{
							v = enableWordWrapping;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "overflowMode",
					PropertyType = typeof(TextOverflowModes),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).overflowMode = (TextOverflowModes)v;
					},
					Getter = (object o) => ((TextMeshPro)o).overflowMode,
					Updater = delegate(object o, ref object v)
					{
						int overflowMode = (int)((TextMeshPro)o).overflowMode;
						if (!overflowMode.Equals((int)v))
						{
							v = overflowMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "horizontalMapping",
					PropertyType = typeof(TextureMappingOptions),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).horizontalMapping = (TextureMappingOptions)v;
					},
					Getter = (object o) => ((TextMeshPro)o).horizontalMapping,
					Updater = delegate(object o, ref object v)
					{
						int horizontalMapping = (int)((TextMeshPro)o).horizontalMapping;
						if (!horizontalMapping.Equals((int)v))
						{
							v = horizontalMapping;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "verticalMapping",
					PropertyType = typeof(TextureMappingOptions),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).verticalMapping = (TextureMappingOptions)v;
					},
					Getter = (object o) => ((TextMeshPro)o).verticalMapping,
					Updater = delegate(object o, ref object v)
					{
						int verticalMapping = (int)((TextMeshPro)o).verticalMapping;
						if (!verticalMapping.Equals((int)v))
						{
							v = verticalMapping;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "margin",
					PropertyType = typeof(Vector4),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).margin = (Vector4)v;
					},
					Getter = (object o) => ((TextMeshPro)o).margin,
					Updater = delegate(object o, ref object v)
					{
						Vector4 margin = ((TextMeshPro)o).margin;
						if (!margin.Equals((Vector4)v))
						{
							v = margin;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingLayerID",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).sortingLayerID = (int)v;
					},
					Getter = (object o) => ((TextMeshPro)o).sortingLayerID,
					Updater = delegate(object o, ref object v)
					{
						int sortingLayerID = ((TextMeshPro)o).sortingLayerID;
						if (!sortingLayerID.Equals((int)v))
						{
							v = sortingLayerID;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingOrder",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).sortingOrder = (int)v;
					},
					Getter = (object o) => ((TextMeshPro)o).sortingOrder,
					Updater = delegate(object o, ref object v)
					{
						int sortingOrder = ((TextMeshPro)o).sortingOrder;
						if (!sortingOrder.Equals((int)v))
						{
							v = sortingOrder;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "geometrySortingOrder",
					PropertyType = typeof(VertexSortingOrder),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).geometrySortingOrder = (VertexSortingOrder)v;
					},
					Getter = (object o) => ((TextMeshPro)o).geometrySortingOrder,
					Updater = delegate(object o, ref object v)
					{
						int geometrySortingOrder = (int)((TextMeshPro)o).geometrySortingOrder;
						if (!geometrySortingOrder.Equals((int)v))
						{
							v = geometrySortingOrder;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTextObjectScaleStatic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).isTextObjectScaleStatic = (bool)v;
					},
					Getter = (object o) => ((TextMeshPro)o).isTextObjectScaleStatic,
					Updater = delegate(object o, ref object v)
					{
						bool isTextObjectScaleStatic = ((TextMeshPro)o).isTextObjectScaleStatic;
						if (!isTextObjectScaleStatic.Equals((bool)v))
						{
							v = isTextObjectScaleStatic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isOrthographic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).isOrthographic = (bool)v;
					},
					Getter = (object o) => ((TextMeshPro)o).isOrthographic,
					Updater = delegate(object o, ref object v)
					{
						bool isOrthographic = ((TextMeshPro)o).isOrthographic;
						if (!isOrthographic.Equals((bool)v))
						{
							v = isOrthographic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "richText",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).richText = (bool)v;
					},
					Getter = (object o) => ((TextMeshPro)o).richText,
					Updater = delegate(object o, ref object v)
					{
						bool richText = ((TextMeshPro)o).richText;
						if (!richText.Equals((bool)v))
						{
							v = richText;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "parseCtrlCharacters",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).parseCtrlCharacters = (bool)v;
					},
					Getter = (object o) => ((TextMeshPro)o).parseCtrlCharacters,
					Updater = delegate(object o, ref object v)
					{
						bool parseCtrlCharacters = ((TextMeshPro)o).parseCtrlCharacters;
						if (!parseCtrlCharacters.Equals((bool)v))
						{
							v = parseCtrlCharacters;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useMaxVisibleDescender",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).useMaxVisibleDescender = (bool)v;
					},
					Getter = (object o) => ((TextMeshPro)o).useMaxVisibleDescender,
					Updater = delegate(object o, ref object v)
					{
						bool useMaxVisibleDescender = ((TextMeshPro)o).useMaxVisibleDescender;
						if (!useMaxVisibleDescender.Equals((bool)v))
						{
							v = useMaxVisibleDescender;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spriteAsset",
					PropertyType = typeof(TMP_SpriteAsset),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).spriteAsset = (TMP_SpriteAsset)v;
					},
					Getter = (object o) => ((TextMeshPro)o).spriteAsset
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "styleSheet",
					PropertyType = typeof(TMP_StyleSheet),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).styleSheet = (TMP_StyleSheet)v;
					},
					Getter = (object o) => ((TextMeshPro)o).styleSheet
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableKerning",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).enableKerning = (bool)v;
					},
					Getter = (object o) => ((TextMeshPro)o).enableKerning,
					Updater = delegate(object o, ref object v)
					{
						bool enableKerning = ((TextMeshPro)o).enableKerning;
						if (!enableKerning.Equals((bool)v))
						{
							v = enableKerning;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "extraPadding",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).extraPadding = (bool)v;
					},
					Getter = (object o) => ((TextMeshPro)o).extraPadding,
					Updater = delegate(object o, ref object v)
					{
						bool extraPadding = ((TextMeshPro)o).extraPadding;
						if (!extraPadding.Equals((bool)v))
						{
							v = extraPadding;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshPro)o).enabled = (bool)v;
					},
					Getter = (object o) => ((TextMeshPro)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((TextMeshPro)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"TMPro.TextMeshProUGUI",
			new ProximaComponentCommands.PropertyInfo[30]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "text",
					PropertyType = typeof(string),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).text = (string)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).text
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "font",
					PropertyType = typeof(TMP_FontAsset),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).font = (TMP_FontAsset)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).font
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fontStyle",
					PropertyType = typeof(FontStyles),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).fontStyle = (FontStyles)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).fontStyle,
					Updater = delegate(object o, ref object v)
					{
						int fontStyle = (int)((TextMeshProUGUI)o).fontStyle;
						if (!fontStyle.Equals((int)v))
						{
							v = fontStyle;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fontSize",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).fontSize = (float)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).fontSize,
					Updater = delegate(object o, ref object v)
					{
						float fontSize = ((TextMeshProUGUI)o).fontSize;
						if (!fontSize.Equals((float)v))
						{
							v = fontSize;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoSizeTextContainer",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).autoSizeTextContainer = (bool)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).autoSizeTextContainer,
					Updater = delegate(object o, ref object v)
					{
						bool autoSizeTextContainer = ((TextMeshProUGUI)o).autoSizeTextContainer;
						if (!autoSizeTextContainer.Equals((bool)v))
						{
							v = autoSizeTextContainer;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "color",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).color = (Color)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).color,
					Updater = delegate(object o, ref object v)
					{
						Color color = ((TextMeshProUGUI)o).color;
						if (!color.Equals((Color)v))
						{
							v = color;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colorGradientPreset",
					PropertyType = typeof(TMP_ColorGradient),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).colorGradientPreset = (TMP_ColorGradient)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).colorGradientPreset
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colorGradient",
					PropertyType = typeof(VertexGradient),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).colorGradient = (VertexGradient)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).colorGradient,
					Updater = delegate(object o, ref object v)
					{
						VertexGradient colorGradient = ((TextMeshProUGUI)o).colorGradient;
						if (!colorGradient.Equals((VertexGradient)v))
						{
							v = colorGradient;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "overrideColorTags",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).overrideColorTags = (bool)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).overrideColorTags,
					Updater = delegate(object o, ref object v)
					{
						bool overrideColorTags = ((TextMeshProUGUI)o).overrideColorTags;
						if (!overrideColorTags.Equals((bool)v))
						{
							v = overrideColorTags;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "characterSpacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).characterSpacing = (float)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).characterSpacing,
					Updater = delegate(object o, ref object v)
					{
						float characterSpacing = ((TextMeshProUGUI)o).characterSpacing;
						if (!characterSpacing.Equals((float)v))
						{
							v = characterSpacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "wordSpacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).wordSpacing = (float)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).wordSpacing,
					Updater = delegate(object o, ref object v)
					{
						float wordSpacing = ((TextMeshProUGUI)o).wordSpacing;
						if (!wordSpacing.Equals((float)v))
						{
							v = wordSpacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lineSpacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).lineSpacing = (float)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).lineSpacing,
					Updater = delegate(object o, ref object v)
					{
						float lineSpacing = ((TextMeshProUGUI)o).lineSpacing;
						if (!lineSpacing.Equals((float)v))
						{
							v = lineSpacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "paragraphSpacing",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).paragraphSpacing = (float)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).paragraphSpacing,
					Updater = delegate(object o, ref object v)
					{
						float paragraphSpacing = ((TextMeshProUGUI)o).paragraphSpacing;
						if (!paragraphSpacing.Equals((float)v))
						{
							v = paragraphSpacing;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "alignment",
					PropertyType = typeof(TextAlignmentOptions),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).alignment = (TextAlignmentOptions)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).alignment,
					Updater = delegate(object o, ref object v)
					{
						int alignment = (int)((TextMeshProUGUI)o).alignment;
						if (!alignment.Equals((int)v))
						{
							v = alignment;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableWordWrapping",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).enableWordWrapping = (bool)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).enableWordWrapping,
					Updater = delegate(object o, ref object v)
					{
						bool enableWordWrapping = ((TextMeshProUGUI)o).enableWordWrapping;
						if (!enableWordWrapping.Equals((bool)v))
						{
							v = enableWordWrapping;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "overflowMode",
					PropertyType = typeof(TextOverflowModes),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).overflowMode = (TextOverflowModes)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).overflowMode,
					Updater = delegate(object o, ref object v)
					{
						int overflowMode = (int)((TextMeshProUGUI)o).overflowMode;
						if (!overflowMode.Equals((int)v))
						{
							v = overflowMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "horizontalMapping",
					PropertyType = typeof(TextureMappingOptions),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).horizontalMapping = (TextureMappingOptions)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).horizontalMapping,
					Updater = delegate(object o, ref object v)
					{
						int horizontalMapping = (int)((TextMeshProUGUI)o).horizontalMapping;
						if (!horizontalMapping.Equals((int)v))
						{
							v = horizontalMapping;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "verticalMapping",
					PropertyType = typeof(TextureMappingOptions),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).verticalMapping = (TextureMappingOptions)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).verticalMapping,
					Updater = delegate(object o, ref object v)
					{
						int verticalMapping = (int)((TextMeshProUGUI)o).verticalMapping;
						if (!verticalMapping.Equals((int)v))
						{
							v = verticalMapping;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "margin",
					PropertyType = typeof(Vector4),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).margin = (Vector4)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).margin,
					Updater = delegate(object o, ref object v)
					{
						Vector4 margin = ((TextMeshProUGUI)o).margin;
						if (!margin.Equals((Vector4)v))
						{
							v = margin;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "geometrySortingOrder",
					PropertyType = typeof(VertexSortingOrder),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).geometrySortingOrder = (VertexSortingOrder)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).geometrySortingOrder,
					Updater = delegate(object o, ref object v)
					{
						int geometrySortingOrder = (int)((TextMeshProUGUI)o).geometrySortingOrder;
						if (!geometrySortingOrder.Equals((int)v))
						{
							v = geometrySortingOrder;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isTextObjectScaleStatic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).isTextObjectScaleStatic = (bool)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).isTextObjectScaleStatic,
					Updater = delegate(object o, ref object v)
					{
						bool isTextObjectScaleStatic = ((TextMeshProUGUI)o).isTextObjectScaleStatic;
						if (!isTextObjectScaleStatic.Equals((bool)v))
						{
							v = isTextObjectScaleStatic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isOrthographic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).isOrthographic = (bool)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).isOrthographic,
					Updater = delegate(object o, ref object v)
					{
						bool isOrthographic = ((TextMeshProUGUI)o).isOrthographic;
						if (!isOrthographic.Equals((bool)v))
						{
							v = isOrthographic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "richText",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).richText = (bool)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).richText,
					Updater = delegate(object o, ref object v)
					{
						bool richText = ((TextMeshProUGUI)o).richText;
						if (!richText.Equals((bool)v))
						{
							v = richText;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "parseCtrlCharacters",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).parseCtrlCharacters = (bool)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).parseCtrlCharacters,
					Updater = delegate(object o, ref object v)
					{
						bool parseCtrlCharacters = ((TextMeshProUGUI)o).parseCtrlCharacters;
						if (!parseCtrlCharacters.Equals((bool)v))
						{
							v = parseCtrlCharacters;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useMaxVisibleDescender",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).useMaxVisibleDescender = (bool)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).useMaxVisibleDescender,
					Updater = delegate(object o, ref object v)
					{
						bool useMaxVisibleDescender = ((TextMeshProUGUI)o).useMaxVisibleDescender;
						if (!useMaxVisibleDescender.Equals((bool)v))
						{
							v = useMaxVisibleDescender;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spriteAsset",
					PropertyType = typeof(TMP_SpriteAsset),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).spriteAsset = (TMP_SpriteAsset)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).spriteAsset
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "styleSheet",
					PropertyType = typeof(TMP_StyleSheet),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).styleSheet = (TMP_StyleSheet)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).styleSheet
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableKerning",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).enableKerning = (bool)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).enableKerning,
					Updater = delegate(object o, ref object v)
					{
						bool enableKerning = ((TextMeshProUGUI)o).enableKerning;
						if (!enableKerning.Equals((bool)v))
						{
							v = enableKerning;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "extraPadding",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).extraPadding = (bool)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).extraPadding,
					Updater = delegate(object o, ref object v)
					{
						bool extraPadding = ((TextMeshProUGUI)o).extraPadding;
						if (!extraPadding.Equals((bool)v))
						{
							v = extraPadding;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TextMeshProUGUI)o).enabled = (bool)v;
					},
					Getter = (object o) => ((TextMeshProUGUI)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((TextMeshProUGUI)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"TMPro.TMP_Dropdown",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "template",
					PropertyType = typeof(RectTransform),
					Setter = (object o, object v) =>
					{
						((TMP_Dropdown)o).template = (RectTransform)v;
					},
					Getter = (object o) => ((TMP_Dropdown)o).template
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "captionText",
					PropertyType = typeof(TMP_Text),
					Setter = (object o, object v) =>
					{
						((TMP_Dropdown)o).captionText = (TMP_Text)v;
					},
					Getter = (object o) => ((TMP_Dropdown)o).captionText
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "captionImage",
					PropertyType = typeof(UnityEngine.UI.Image),
					Setter = (object o, object v) =>
					{
						((TMP_Dropdown)o).captionImage = (UnityEngine.UI.Image)v;
					},
					Getter = (object o) => ((TMP_Dropdown)o).captionImage
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "placeholder",
					PropertyType = typeof(Graphic),
					Setter = (object o, object v) =>
					{
						((TMP_Dropdown)o).placeholder = (Graphic)v;
					},
					Getter = (object o) => ((TMP_Dropdown)o).placeholder
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "itemText",
					PropertyType = typeof(TMP_Text),
					Setter = (object o, object v) =>
					{
						((TMP_Dropdown)o).itemText = (TMP_Text)v;
					},
					Getter = (object o) => ((TMP_Dropdown)o).itemText
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "itemImage",
					PropertyType = typeof(UnityEngine.UI.Image),
					Setter = (object o, object v) =>
					{
						((TMP_Dropdown)o).itemImage = (UnityEngine.UI.Image)v;
					},
					Getter = (object o) => ((TMP_Dropdown)o).itemImage
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "value",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((TMP_Dropdown)o).value = (int)v;
					},
					Getter = (object o) => ((TMP_Dropdown)o).value,
					Updater = delegate(object o, ref object v)
					{
						int value = ((TMP_Dropdown)o).value;
						if (!value.Equals((int)v))
						{
							v = value;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "alphaFadeSpeed",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TMP_Dropdown)o).alphaFadeSpeed = (float)v;
					},
					Getter = (object o) => ((TMP_Dropdown)o).alphaFadeSpeed,
					Updater = delegate(object o, ref object v)
					{
						float alphaFadeSpeed = ((TMP_Dropdown)o).alphaFadeSpeed;
						if (!alphaFadeSpeed.Equals((float)v))
						{
							v = alphaFadeSpeed;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "options",
					PropertyType = typeof(List<TMP_Dropdown.OptionData>),
					Setter = (object o, object v) =>
					{
						((TMP_Dropdown)o).options = (List<TMP_Dropdown.OptionData>)v;
					},
					Getter = (object o) => ((TMP_Dropdown)o).options
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_Dropdown)o).enabled = (bool)v;
					},
					Getter = (object o) => ((TMP_Dropdown)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((TMP_Dropdown)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"TMPro.TMP_InputField",
			new ProximaComponentCommands.PropertyInfo[28]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "interactable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).interactable = (bool)v;
					},
					Getter = (object o) => ((TMP_InputField)o).interactable,
					Updater = delegate(object o, ref object v)
					{
						bool interactable = ((TMP_InputField)o).interactable;
						if (!interactable.Equals((bool)v))
						{
							v = interactable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "transition",
					PropertyType = typeof(Selectable.Transition),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).transition = (Selectable.Transition)v;
					},
					Getter = (object o) => ((TMP_InputField)o).transition,
					Updater = delegate(object o, ref object v)
					{
						int transition = (int)((TMP_InputField)o).transition;
						if (!transition.Equals((int)v))
						{
							v = transition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetGraphic",
					PropertyType = typeof(Graphic),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).targetGraphic = (Graphic)v;
					},
					Getter = (object o) => ((TMP_InputField)o).targetGraphic
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colors",
					PropertyType = typeof(ColorBlock),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).colors = (ColorBlock)v;
					},
					Getter = (object o) => ((TMP_InputField)o).colors,
					Updater = delegate(object o, ref object v)
					{
						ColorBlock colors = ((TMP_InputField)o).colors;
						if (!colors.Equals((ColorBlock)v))
						{
							v = colors;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "navigation",
					PropertyType = typeof(Navigation),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).navigation = (Navigation)v;
					},
					Getter = (object o) => ((TMP_InputField)o).navigation,
					Updater = delegate(object o, ref object v)
					{
						Navigation navigation = ((TMP_InputField)o).navigation;
						if (!navigation.Equals((Navigation)v))
						{
							v = navigation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "textViewport",
					PropertyType = typeof(RectTransform),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).textViewport = (RectTransform)v;
					},
					Getter = (object o) => ((TMP_InputField)o).textViewport
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "textComponent",
					PropertyType = typeof(TMP_Text),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).textComponent = (TMP_Text)v;
					},
					Getter = (object o) => ((TMP_InputField)o).textComponent
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "text",
					PropertyType = typeof(string),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).text = (string)v;
					},
					Getter = (object o) => ((TMP_InputField)o).text
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fontAsset",
					PropertyType = typeof(TMP_FontAsset),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).fontAsset = (TMP_FontAsset)v;
					},
					Getter = (object o) => ((TMP_InputField)o).fontAsset
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "pointSize",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).pointSize = (float)v;
					},
					Getter = (object o) => ((TMP_InputField)o).pointSize,
					Updater = delegate(object o, ref object v)
					{
						float pointSize = ((TMP_InputField)o).pointSize;
						if (!pointSize.Equals((float)v))
						{
							v = pointSize;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "characterLimit",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).characterLimit = (int)v;
					},
					Getter = (object o) => ((TMP_InputField)o).characterLimit,
					Updater = delegate(object o, ref object v)
					{
						int characterLimit = ((TMP_InputField)o).characterLimit;
						if (!characterLimit.Equals((int)v))
						{
							v = characterLimit;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "contentType",
					PropertyType = typeof(TMP_InputField.ContentType),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).contentType = (TMP_InputField.ContentType)v;
					},
					Getter = (object o) => ((TMP_InputField)o).contentType,
					Updater = delegate(object o, ref object v)
					{
						int contentType = (int)((TMP_InputField)o).contentType;
						if (!contentType.Equals((int)v))
						{
							v = contentType;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lineType",
					PropertyType = typeof(TMP_InputField.LineType),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).lineType = (TMP_InputField.LineType)v;
					},
					Getter = (object o) => ((TMP_InputField)o).lineType,
					Updater = delegate(object o, ref object v)
					{
						int lineType = (int)((TMP_InputField)o).lineType;
						if (!lineType.Equals((int)v))
						{
							v = lineType;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "placeholder",
					PropertyType = typeof(Graphic),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).placeholder = (Graphic)v;
					},
					Getter = (object o) => ((TMP_InputField)o).placeholder
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "verticalScrollbar",
					PropertyType = typeof(Scrollbar),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).verticalScrollbar = (Scrollbar)v;
					},
					Getter = (object o) => ((TMP_InputField)o).verticalScrollbar
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "caretBlinkRate",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).caretBlinkRate = (float)v;
					},
					Getter = (object o) => ((TMP_InputField)o).caretBlinkRate,
					Updater = delegate(object o, ref object v)
					{
						float caretBlinkRate = ((TMP_InputField)o).caretBlinkRate;
						if (!caretBlinkRate.Equals((float)v))
						{
							v = caretBlinkRate;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "caretWidth",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).caretWidth = (int)v;
					},
					Getter = (object o) => ((TMP_InputField)o).caretWidth,
					Updater = delegate(object o, ref object v)
					{
						int caretWidth = ((TMP_InputField)o).caretWidth;
						if (!caretWidth.Equals((int)v))
						{
							v = caretWidth;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "customCaretColor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).customCaretColor = (bool)v;
					},
					Getter = (object o) => ((TMP_InputField)o).customCaretColor,
					Updater = delegate(object o, ref object v)
					{
						bool customCaretColor = ((TMP_InputField)o).customCaretColor;
						if (!customCaretColor.Equals((bool)v))
						{
							v = customCaretColor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "selectionColor",
					PropertyType = typeof(Color),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).selectionColor = (Color)v;
					},
					Getter = (object o) => ((TMP_InputField)o).selectionColor,
					Updater = delegate(object o, ref object v)
					{
						Color selectionColor = ((TMP_InputField)o).selectionColor;
						if (!selectionColor.Equals((Color)v))
						{
							v = selectionColor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "onFocusSelectAll",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).onFocusSelectAll = (bool)v;
					},
					Getter = (object o) => ((TMP_InputField)o).onFocusSelectAll,
					Updater = delegate(object o, ref object v)
					{
						bool onFocusSelectAll = ((TMP_InputField)o).onFocusSelectAll;
						if (!onFocusSelectAll.Equals((bool)v))
						{
							v = onFocusSelectAll;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "resetOnDeActivation",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).resetOnDeActivation = (bool)v;
					},
					Getter = (object o) => ((TMP_InputField)o).resetOnDeActivation,
					Updater = delegate(object o, ref object v)
					{
						bool resetOnDeActivation = ((TMP_InputField)o).resetOnDeActivation;
						if (!resetOnDeActivation.Equals((bool)v))
						{
							v = resetOnDeActivation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "restoreOriginalTextOnEscape",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).restoreOriginalTextOnEscape = (bool)v;
					},
					Getter = (object o) => ((TMP_InputField)o).restoreOriginalTextOnEscape,
					Updater = delegate(object o, ref object v)
					{
						bool restoreOriginalTextOnEscape = ((TMP_InputField)o).restoreOriginalTextOnEscape;
						if (!restoreOriginalTextOnEscape.Equals((bool)v))
						{
							v = restoreOriginalTextOnEscape;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shouldHideSoftKeyboard",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).shouldHideSoftKeyboard = (bool)v;
					},
					Getter = (object o) => ((TMP_InputField)o).shouldHideSoftKeyboard,
					Updater = delegate(object o, ref object v)
					{
						bool shouldHideSoftKeyboard = ((TMP_InputField)o).shouldHideSoftKeyboard;
						if (!shouldHideSoftKeyboard.Equals((bool)v))
						{
							v = shouldHideSoftKeyboard;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shouldHideMobileInput",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).shouldHideMobileInput = (bool)v;
					},
					Getter = (object o) => ((TMP_InputField)o).shouldHideMobileInput,
					Updater = delegate(object o, ref object v)
					{
						bool shouldHideMobileInput = ((TMP_InputField)o).shouldHideMobileInput;
						if (!shouldHideMobileInput.Equals((bool)v))
						{
							v = shouldHideMobileInput;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "readOnly",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).readOnly = (bool)v;
					},
					Getter = (object o) => ((TMP_InputField)o).readOnly,
					Updater = delegate(object o, ref object v)
					{
						bool readOnly = ((TMP_InputField)o).readOnly;
						if (!readOnly.Equals((bool)v))
						{
							v = readOnly;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "richText",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).richText = (bool)v;
					},
					Getter = (object o) => ((TMP_InputField)o).richText,
					Updater = delegate(object o, ref object v)
					{
						bool richText = ((TMP_InputField)o).richText;
						if (!richText.Equals((bool)v))
						{
							v = richText;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isRichTextEditingAllowed",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).isRichTextEditingAllowed = (bool)v;
					},
					Getter = (object o) => ((TMP_InputField)o).isRichTextEditingAllowed,
					Updater = delegate(object o, ref object v)
					{
						bool isRichTextEditingAllowed = ((TMP_InputField)o).isRichTextEditingAllowed;
						if (!isRichTextEditingAllowed.Equals((bool)v))
						{
							v = isRichTextEditingAllowed;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_InputField)o).enabled = (bool)v;
					},
					Getter = (object o) => ((TMP_InputField)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((TMP_InputField)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"TMPro.TMP_ScrollbarEventHandler",
			new ProximaComponentCommands.PropertyInfo[2]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isSelected",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_ScrollbarEventHandler)o).isSelected = (bool)v;
					},
					Getter = (object o) => ((TMP_ScrollbarEventHandler)o).isSelected,
					Updater = delegate(object o, ref object v)
					{
						bool isSelected = ((TMP_ScrollbarEventHandler)o).isSelected;
						if (!isSelected.Equals((bool)v))
						{
							v = isSelected;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_ScrollbarEventHandler)o).enabled = (bool)v;
					},
					Getter = (object o) => ((TMP_ScrollbarEventHandler)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((TMP_ScrollbarEventHandler)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"TMPro.TMP_SubMesh",
			new ProximaComponentCommands.PropertyInfo[3]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fontAsset",
					PropertyType = typeof(TMP_FontAsset),
					Setter = (object o, object v) =>
					{
						((TMP_SubMesh)o).fontAsset = (TMP_FontAsset)v;
					},
					Getter = (object o) => ((TMP_SubMesh)o).fontAsset
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spriteAsset",
					PropertyType = typeof(TMP_SpriteAsset),
					Setter = (object o, object v) =>
					{
						((TMP_SubMesh)o).spriteAsset = (TMP_SpriteAsset)v;
					},
					Getter = (object o) => ((TMP_SubMesh)o).spriteAsset
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_SubMesh)o).enabled = (bool)v;
					},
					Getter = (object o) => ((TMP_SubMesh)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((TMP_SubMesh)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"TMPro.TMP_SubMeshUI",
			new ProximaComponentCommands.PropertyInfo[3]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "fontAsset",
					PropertyType = typeof(TMP_FontAsset),
					Setter = (object o, object v) =>
					{
						((TMP_SubMeshUI)o).fontAsset = (TMP_FontAsset)v;
					},
					Getter = (object o) => ((TMP_SubMeshUI)o).fontAsset
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "spriteAsset",
					PropertyType = typeof(TMP_SpriteAsset),
					Setter = (object o, object v) =>
					{
						((TMP_SubMeshUI)o).spriteAsset = (TMP_SpriteAsset)v;
					},
					Getter = (object o) => ((TMP_SubMeshUI)o).spriteAsset
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TMP_SubMeshUI)o).enabled = (bool)v;
					},
					Getter = (object o) => ((TMP_SubMeshUI)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((TMP_SubMeshUI)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.Toggle",
			new ProximaComponentCommands.PropertyInfo[10]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "interactable",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Toggle)o).interactable = (bool)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Toggle)o).interactable,
					Updater = delegate(object o, ref object v)
					{
						bool interactable = ((UnityEngine.UI.Toggle)o).interactable;
						if (!interactable.Equals((bool)v))
						{
							v = interactable;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "transition",
					PropertyType = typeof(Selectable.Transition),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Toggle)o).transition = (Selectable.Transition)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Toggle)o).transition,
					Updater = delegate(object o, ref object v)
					{
						int transition = (int)((UnityEngine.UI.Toggle)o).transition;
						if (!transition.Equals((int)v))
						{
							v = transition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetGraphic",
					PropertyType = typeof(Graphic),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Toggle)o).targetGraphic = (Graphic)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Toggle)o).targetGraphic
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colors",
					PropertyType = typeof(ColorBlock),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Toggle)o).colors = (ColorBlock)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Toggle)o).colors,
					Updater = delegate(object o, ref object v)
					{
						ColorBlock colors = ((UnityEngine.UI.Toggle)o).colors;
						if (!colors.Equals((ColorBlock)v))
						{
							v = colors;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "navigation",
					PropertyType = typeof(Navigation),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Toggle)o).navigation = (Navigation)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Toggle)o).navigation,
					Updater = delegate(object o, ref object v)
					{
						Navigation navigation = ((UnityEngine.UI.Toggle)o).navigation;
						if (!navigation.Equals((Navigation)v))
						{
							v = navigation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isOn",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Toggle)o).isOn = (bool)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Toggle)o).isOn,
					Updater = delegate(object o, ref object v)
					{
						bool isOn = ((UnityEngine.UI.Toggle)o).isOn;
						if (!isOn.Equals((bool)v))
						{
							v = isOn;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "toggleTransition",
					PropertyType = typeof(UnityEngine.UI.Toggle.ToggleTransition),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Toggle)o).toggleTransition = (UnityEngine.UI.Toggle.ToggleTransition)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Toggle)o).toggleTransition,
					Updater = delegate(object o, ref object v)
					{
						int toggleTransition = (int)((UnityEngine.UI.Toggle)o).toggleTransition;
						if (!toggleTransition.Equals((int)v))
						{
							v = toggleTransition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "graphic",
					PropertyType = typeof(Graphic),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Toggle)o).graphic = (Graphic)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Toggle)o).graphic
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "group",
					PropertyType = typeof(ToggleGroup),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Toggle)o).group = (ToggleGroup)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Toggle)o).group
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UnityEngine.UI.Toggle)o).enabled = (bool)v;
					},
					Getter = (object o) => ((UnityEngine.UI.Toggle)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((UnityEngine.UI.Toggle)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UI.ToggleGroup",
			new ProximaComponentCommands.PropertyInfo[2]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "allowSwitchOff",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ToggleGroup)o).allowSwitchOff = (bool)v;
					},
					Getter = (object o) => ((ToggleGroup)o).allowSwitchOff,
					Updater = delegate(object o, ref object v)
					{
						bool allowSwitchOff = ((ToggleGroup)o).allowSwitchOff;
						if (!allowSwitchOff.Equals((bool)v))
						{
							v = allowSwitchOff;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((ToggleGroup)o).enabled = (bool)v;
					},
					Getter = (object o) => ((ToggleGroup)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((ToggleGroup)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.TrailRenderer",
			new ProximaComponentCommands.PropertyInfo[21]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "time",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).time = (float)v;
					},
					Getter = (object o) => ((TrailRenderer)o).time,
					Updater = delegate(object o, ref object v)
					{
						float time = ((TrailRenderer)o).time;
						if (!time.Equals((float)v))
						{
							v = time;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "minVertexDistance",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).minVertexDistance = (float)v;
					},
					Getter = (object o) => ((TrailRenderer)o).minVertexDistance,
					Updater = delegate(object o, ref object v)
					{
						float minVertexDistance = ((TrailRenderer)o).minVertexDistance;
						if (!minVertexDistance.Equals((float)v))
						{
							v = minVertexDistance;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autodestruct",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).autodestruct = (bool)v;
					},
					Getter = (object o) => ((TrailRenderer)o).autodestruct,
					Updater = delegate(object o, ref object v)
					{
						bool autodestruct = ((TrailRenderer)o).autodestruct;
						if (!autodestruct.Equals((bool)v))
						{
							v = autodestruct;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "emitting",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).emitting = (bool)v;
					},
					Getter = (object o) => ((TrailRenderer)o).emitting,
					Updater = delegate(object o, ref object v)
					{
						bool emitting = ((TrailRenderer)o).emitting;
						if (!emitting.Equals((bool)v))
						{
							v = emitting;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "colorGradient",
					PropertyType = typeof(Gradient),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).colorGradient = (Gradient)v;
					},
					Getter = (object o) => ((TrailRenderer)o).colorGradient
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "numCornerVertices",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).numCornerVertices = (int)v;
					},
					Getter = (object o) => ((TrailRenderer)o).numCornerVertices,
					Updater = delegate(object o, ref object v)
					{
						int numCornerVertices = ((TrailRenderer)o).numCornerVertices;
						if (!numCornerVertices.Equals((int)v))
						{
							v = numCornerVertices;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "numCapVertices",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).numCapVertices = (int)v;
					},
					Getter = (object o) => ((TrailRenderer)o).numCapVertices,
					Updater = delegate(object o, ref object v)
					{
						int numCapVertices = ((TrailRenderer)o).numCapVertices;
						if (!numCapVertices.Equals((int)v))
						{
							v = numCapVertices;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "alignment",
					PropertyType = typeof(LineAlignment),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).alignment = (LineAlignment)v;
					},
					Getter = (object o) => ((TrailRenderer)o).alignment,
					Updater = delegate(object o, ref object v)
					{
						int alignment = (int)((TrailRenderer)o).alignment;
						if (!alignment.Equals((int)v))
						{
							v = alignment;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "textureMode",
					PropertyType = typeof(LineTextureMode),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).textureMode = (LineTextureMode)v;
					},
					Getter = (object o) => ((TrailRenderer)o).textureMode,
					Updater = delegate(object o, ref object v)
					{
						int textureMode = (int)((TrailRenderer)o).textureMode;
						if (!textureMode.Equals((int)v))
						{
							v = textureMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "generateLightingData",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).generateLightingData = (bool)v;
					},
					Getter = (object o) => ((TrailRenderer)o).generateLightingData,
					Updater = delegate(object o, ref object v)
					{
						bool generateLightingData = ((TrailRenderer)o).generateLightingData;
						if (!generateLightingData.Equals((bool)v))
						{
							v = generateLightingData;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shadowBias",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).shadowBias = (float)v;
					},
					Getter = (object o) => ((TrailRenderer)o).shadowBias,
					Updater = delegate(object o, ref object v)
					{
						float shadowBias = ((TrailRenderer)o).shadowBias;
						if (!shadowBias.Equals((float)v))
						{
							v = shadowBias;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sharedMaterials",
					PropertyType = typeof(Material[]),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).sharedMaterials = (Material[])v;
					},
					Getter = (object o) => ((TrailRenderer)o).sharedMaterials,
					Updater = delegate(object o, ref object v)
					{
						Material[] sharedMaterials = ((TrailRenderer)o).sharedMaterials;
						if (sharedMaterials.Length != ((Material[])v).Length)
						{
							v = sharedMaterials;
							return true;
						}
						v = sharedMaterials;
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "shadowCastingMode",
					PropertyType = typeof(ShadowCastingMode),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).shadowCastingMode = (ShadowCastingMode)v;
					},
					Getter = (object o) => ((TrailRenderer)o).shadowCastingMode,
					Updater = delegate(object o, ref object v)
					{
						int shadowCastingMode = (int)((TrailRenderer)o).shadowCastingMode;
						if (!shadowCastingMode.Equals((int)v))
						{
							v = shadowCastingMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "receiveShadows",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).receiveShadows = (bool)v;
					},
					Getter = (object o) => ((TrailRenderer)o).receiveShadows,
					Updater = delegate(object o, ref object v)
					{
						bool receiveShadows = ((TrailRenderer)o).receiveShadows;
						if (!receiveShadows.Equals((bool)v))
						{
							v = receiveShadows;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "lightProbeUsage",
					PropertyType = typeof(LightProbeUsage),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).lightProbeUsage = (LightProbeUsage)v;
					},
					Getter = (object o) => ((TrailRenderer)o).lightProbeUsage,
					Updater = delegate(object o, ref object v)
					{
						int lightProbeUsage = (int)((TrailRenderer)o).lightProbeUsage;
						if (!lightProbeUsage.Equals((int)v))
						{
							v = lightProbeUsage;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "reflectionProbeUsage",
					PropertyType = typeof(ReflectionProbeUsage),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).reflectionProbeUsage = (ReflectionProbeUsage)v;
					},
					Getter = (object o) => ((TrailRenderer)o).reflectionProbeUsage,
					Updater = delegate(object o, ref object v)
					{
						int reflectionProbeUsage = (int)((TrailRenderer)o).reflectionProbeUsage;
						if (!reflectionProbeUsage.Equals((int)v))
						{
							v = reflectionProbeUsage;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "motionVectorGenerationMode",
					PropertyType = typeof(MotionVectorGenerationMode),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).motionVectorGenerationMode = (MotionVectorGenerationMode)v;
					},
					Getter = (object o) => ((TrailRenderer)o).motionVectorGenerationMode,
					Updater = delegate(object o, ref object v)
					{
						int motionVectorGenerationMode = (int)((TrailRenderer)o).motionVectorGenerationMode;
						if (!motionVectorGenerationMode.Equals((int)v))
						{
							v = motionVectorGenerationMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "allowOcclusionWhenDynamic",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).allowOcclusionWhenDynamic = (bool)v;
					},
					Getter = (object o) => ((TrailRenderer)o).allowOcclusionWhenDynamic,
					Updater = delegate(object o, ref object v)
					{
						bool allowOcclusionWhenDynamic = ((TrailRenderer)o).allowOcclusionWhenDynamic;
						if (!allowOcclusionWhenDynamic.Equals((bool)v))
						{
							v = allowOcclusionWhenDynamic;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingLayerID",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).sortingLayerID = (int)v;
					},
					Getter = (object o) => ((TrailRenderer)o).sortingLayerID,
					Updater = delegate(object o, ref object v)
					{
						int sortingLayerID = ((TrailRenderer)o).sortingLayerID;
						if (!sortingLayerID.Equals((int)v))
						{
							v = sortingLayerID;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingOrder",
					PropertyType = typeof(int),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).sortingOrder = (int)v;
					},
					Getter = (object o) => ((TrailRenderer)o).sortingOrder,
					Updater = delegate(object o, ref object v)
					{
						int sortingOrder = ((TrailRenderer)o).sortingOrder;
						if (!sortingOrder.Equals((int)v))
						{
							v = sortingOrder;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((TrailRenderer)o).enabled = (bool)v;
					},
					Getter = (object o) => ((TrailRenderer)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((TrailRenderer)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Transform",
			new ProximaComponentCommands.PropertyInfo[3]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "localPosition",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((Transform)o).localPosition = (Vector3)v;
					},
					Getter = (object o) => ((Transform)o).localPosition,
					Updater = delegate(object o, ref object v)
					{
						Vector3 localPosition = ((Transform)o).localPosition;
						if (!localPosition.Equals((Vector3)v))
						{
							v = localPosition;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "localRotation",
					PropertyType = typeof(Quaternion),
					Setter = (object o, object v) =>
					{
						((Transform)o).localRotation = (Quaternion)v;
					},
					Getter = (object o) => ((Transform)o).localRotation,
					Updater = delegate(object o, ref object v)
					{
						Quaternion localRotation = ((Transform)o).localRotation;
						if (!localRotation.Equals((Quaternion)v))
						{
							v = localRotation;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "localScale",
					PropertyType = typeof(Vector3),
					Setter = (object o, object v) =>
					{
						((Transform)o).localScale = (Vector3)v;
					},
					Getter = (object o) => ((Transform)o).localScale,
					Updater = delegate(object o, ref object v)
					{
						Vector3 localScale = ((Transform)o).localScale;
						if (!localScale.Equals((Vector3)v))
						{
							v = localScale;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.UIElements.UIDocument",
			new ProximaComponentCommands.PropertyInfo[4]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "panelSettings",
					PropertyType = typeof(PanelSettings),
					Setter = (object o, object v) =>
					{
						((UIDocument)o).panelSettings = (PanelSettings)v;
					},
					Getter = (object o) => ((UIDocument)o).panelSettings
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "visualTreeAsset",
					PropertyType = typeof(VisualTreeAsset),
					Setter = (object o, object v) =>
					{
						((UIDocument)o).visualTreeAsset = (VisualTreeAsset)v;
					},
					Getter = (object o) => ((UIDocument)o).visualTreeAsset
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "sortingOrder",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((UIDocument)o).sortingOrder = (float)v;
					},
					Getter = (object o) => ((UIDocument)o).sortingOrder,
					Updater = delegate(object o, ref object v)
					{
						float sortingOrder = ((UIDocument)o).sortingOrder;
						if (!sortingOrder.Equals((float)v))
						{
							v = sortingOrder;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((UIDocument)o).enabled = (bool)v;
					},
					Getter = (object o) => ((UIDocument)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((UIDocument)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.Video.VideoPlayer",
			new ProximaComponentCommands.PropertyInfo[16]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "source",
					PropertyType = typeof(VideoSource),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).source = (VideoSource)v;
					},
					Getter = (object o) => ((VideoPlayer)o).source,
					Updater = delegate(object o, ref object v)
					{
						int source = (int)((VideoPlayer)o).source;
						if (!source.Equals((int)v))
						{
							v = source;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "clip",
					PropertyType = typeof(VideoClip),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).clip = (VideoClip)v;
					},
					Getter = (object o) => ((VideoPlayer)o).clip
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "url",
					PropertyType = typeof(string),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).url = (string)v;
					},
					Getter = (object o) => ((VideoPlayer)o).url
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "playOnAwake",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).playOnAwake = (bool)v;
					},
					Getter = (object o) => ((VideoPlayer)o).playOnAwake,
					Updater = delegate(object o, ref object v)
					{
						bool playOnAwake = ((VideoPlayer)o).playOnAwake;
						if (!playOnAwake.Equals((bool)v))
						{
							v = playOnAwake;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "waitForFirstFrame",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).waitForFirstFrame = (bool)v;
					},
					Getter = (object o) => ((VideoPlayer)o).waitForFirstFrame,
					Updater = delegate(object o, ref object v)
					{
						bool waitForFirstFrame = ((VideoPlayer)o).waitForFirstFrame;
						if (!waitForFirstFrame.Equals((bool)v))
						{
							v = waitForFirstFrame;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "isLooping",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).isLooping = (bool)v;
					},
					Getter = (object o) => ((VideoPlayer)o).isLooping,
					Updater = delegate(object o, ref object v)
					{
						bool isLooping = ((VideoPlayer)o).isLooping;
						if (!isLooping.Equals((bool)v))
						{
							v = isLooping;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "skipOnDrop",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).skipOnDrop = (bool)v;
					},
					Getter = (object o) => ((VideoPlayer)o).skipOnDrop,
					Updater = delegate(object o, ref object v)
					{
						bool skipOnDrop = ((VideoPlayer)o).skipOnDrop;
						if (!skipOnDrop.Equals((bool)v))
						{
							v = skipOnDrop;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "playbackSpeed",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).playbackSpeed = (float)v;
					},
					Getter = (object o) => ((VideoPlayer)o).playbackSpeed,
					Updater = delegate(object o, ref object v)
					{
						float playbackSpeed = ((VideoPlayer)o).playbackSpeed;
						if (!playbackSpeed.Equals((float)v))
						{
							v = playbackSpeed;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "renderMode",
					PropertyType = typeof(VideoRenderMode),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).renderMode = (VideoRenderMode)v;
					},
					Getter = (object o) => ((VideoPlayer)o).renderMode,
					Updater = delegate(object o, ref object v)
					{
						int renderMode = (int)((VideoPlayer)o).renderMode;
						if (!renderMode.Equals((int)v))
						{
							v = renderMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetCamera",
					PropertyType = typeof(Camera),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).targetCamera = (Camera)v;
					},
					Getter = (object o) => ((VideoPlayer)o).targetCamera
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetCameraAlpha",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).targetCameraAlpha = (float)v;
					},
					Getter = (object o) => ((VideoPlayer)o).targetCameraAlpha,
					Updater = delegate(object o, ref object v)
					{
						float targetCameraAlpha = ((VideoPlayer)o).targetCameraAlpha;
						if (!targetCameraAlpha.Equals((float)v))
						{
							v = targetCameraAlpha;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "targetCamera3DLayout",
					PropertyType = typeof(Video3DLayout),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).targetCamera3DLayout = (Video3DLayout)v;
					},
					Getter = (object o) => ((VideoPlayer)o).targetCamera3DLayout,
					Updater = delegate(object o, ref object v)
					{
						int targetCamera3DLayout = (int)((VideoPlayer)o).targetCamera3DLayout;
						if (!targetCamera3DLayout.Equals((int)v))
						{
							v = targetCamera3DLayout;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "aspectRatio",
					PropertyType = typeof(VideoAspectRatio),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).aspectRatio = (VideoAspectRatio)v;
					},
					Getter = (object o) => ((VideoPlayer)o).aspectRatio,
					Updater = delegate(object o, ref object v)
					{
						int aspectRatio = (int)((VideoPlayer)o).aspectRatio;
						if (!aspectRatio.Equals((int)v))
						{
							v = aspectRatio;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "audioOutputMode",
					PropertyType = typeof(VideoAudioOutputMode),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).audioOutputMode = (VideoAudioOutputMode)v;
					},
					Getter = (object o) => ((VideoPlayer)o).audioOutputMode,
					Updater = delegate(object o, ref object v)
					{
						int audioOutputMode = (int)((VideoPlayer)o).audioOutputMode;
						if (!audioOutputMode.Equals((int)v))
						{
							v = audioOutputMode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "controlledAudioTrackCount",
					PropertyType = typeof(ushort),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).controlledAudioTrackCount = (ushort)v;
					},
					Getter = (object o) => ((VideoPlayer)o).controlledAudioTrackCount,
					Updater = delegate(object o, ref object v)
					{
						ushort controlledAudioTrackCount = ((VideoPlayer)o).controlledAudioTrackCount;
						if (!controlledAudioTrackCount.Equals((ushort)v))
						{
							v = controlledAudioTrackCount;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((VideoPlayer)o).enabled = (bool)v;
					},
					Getter = (object o) => ((VideoPlayer)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((VideoPlayer)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.WheelJoint2D",
			new ProximaComponentCommands.PropertyInfo[11]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enableCollision",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((WheelJoint2D)o).enableCollision = (bool)v;
					},
					Getter = (object o) => ((WheelJoint2D)o).enableCollision,
					Updater = delegate(object o, ref object v)
					{
						bool enableCollision = ((WheelJoint2D)o).enableCollision;
						if (!enableCollision.Equals((bool)v))
						{
							v = enableCollision;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedBody",
					PropertyType = typeof(Rigidbody2D),
					Setter = (object o, object v) =>
					{
						((WheelJoint2D)o).connectedBody = (Rigidbody2D)v;
					},
					Getter = (object o) => ((WheelJoint2D)o).connectedBody
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "autoConfigureConnectedAnchor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((WheelJoint2D)o).autoConfigureConnectedAnchor = (bool)v;
					},
					Getter = (object o) => ((WheelJoint2D)o).autoConfigureConnectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						bool autoConfigureConnectedAnchor = ((WheelJoint2D)o).autoConfigureConnectedAnchor;
						if (!autoConfigureConnectedAnchor.Equals((bool)v))
						{
							v = autoConfigureConnectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "anchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((WheelJoint2D)o).anchor = (Vector2)v;
					},
					Getter = (object o) => ((WheelJoint2D)o).anchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 anchor = ((WheelJoint2D)o).anchor;
						if (!anchor.Equals((Vector2)v))
						{
							v = anchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "connectedAnchor",
					PropertyType = typeof(Vector2),
					Setter = (object o, object v) =>
					{
						((WheelJoint2D)o).connectedAnchor = (Vector2)v;
					},
					Getter = (object o) => ((WheelJoint2D)o).connectedAnchor,
					Updater = delegate(object o, ref object v)
					{
						Vector2 connectedAnchor = ((WheelJoint2D)o).connectedAnchor;
						if (!connectedAnchor.Equals((Vector2)v))
						{
							v = connectedAnchor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "suspension",
					PropertyType = typeof(JointSuspension2D),
					Setter = (object o, object v) =>
					{
						((WheelJoint2D)o).suspension = (JointSuspension2D)v;
					},
					Getter = (object o) => ((WheelJoint2D)o).suspension,
					Updater = delegate(object o, ref object v)
					{
						JointSuspension2D suspension = ((WheelJoint2D)o).suspension;
						if (!suspension.Equals((JointSuspension2D)v))
						{
							v = suspension;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "useMotor",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((WheelJoint2D)o).useMotor = (bool)v;
					},
					Getter = (object o) => ((WheelJoint2D)o).useMotor,
					Updater = delegate(object o, ref object v)
					{
						bool useMotor = ((WheelJoint2D)o).useMotor;
						if (!useMotor.Equals((bool)v))
						{
							v = useMotor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "motor",
					PropertyType = typeof(JointMotor2D),
					Setter = (object o, object v) =>
					{
						((WheelJoint2D)o).motor = (JointMotor2D)v;
					},
					Getter = (object o) => ((WheelJoint2D)o).motor,
					Updater = delegate(object o, ref object v)
					{
						JointMotor2D motor = ((WheelJoint2D)o).motor;
						if (!motor.Equals((JointMotor2D)v))
						{
							v = motor;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakForce",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((WheelJoint2D)o).breakForce = (float)v;
					},
					Getter = (object o) => ((WheelJoint2D)o).breakForce,
					Updater = delegate(object o, ref object v)
					{
						float breakForce = ((WheelJoint2D)o).breakForce;
						if (!breakForce.Equals((float)v))
						{
							v = breakForce;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "breakTorque",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((WheelJoint2D)o).breakTorque = (float)v;
					},
					Getter = (object o) => ((WheelJoint2D)o).breakTorque,
					Updater = delegate(object o, ref object v)
					{
						float breakTorque = ((WheelJoint2D)o).breakTorque;
						if (!breakTorque.Equals((float)v))
						{
							v = breakTorque;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "enabled",
					PropertyType = typeof(bool),
					Setter = (object o, object v) =>
					{
						((WheelJoint2D)o).enabled = (bool)v;
					},
					Getter = (object o) => ((WheelJoint2D)o).enabled,
					Updater = delegate(object o, ref object v)
					{
						bool enabled = ((WheelJoint2D)o).enabled;
						if (!enabled.Equals((bool)v))
						{
							v = enabled;
							return true;
						}
						return false;
					}
				}
			}
		},
		{
			"UnityEngine.WindZone",
			new ProximaComponentCommands.PropertyInfo[5]
			{
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "mode",
					PropertyType = typeof(WindZoneMode),
					Setter = (object o, object v) =>
					{
						((WindZone)o).mode = (WindZoneMode)v;
					},
					Getter = (object o) => ((WindZone)o).mode,
					Updater = delegate(object o, ref object v)
					{
						int mode = (int)((WindZone)o).mode;
						if (!mode.Equals((int)v))
						{
							v = mode;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "windMain",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((WindZone)o).windMain = (float)v;
					},
					Getter = (object o) => ((WindZone)o).windMain,
					Updater = delegate(object o, ref object v)
					{
						float windMain = ((WindZone)o).windMain;
						if (!windMain.Equals((float)v))
						{
							v = windMain;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "windTurbulence",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((WindZone)o).windTurbulence = (float)v;
					},
					Getter = (object o) => ((WindZone)o).windTurbulence,
					Updater = delegate(object o, ref object v)
					{
						float windTurbulence = ((WindZone)o).windTurbulence;
						if (!windTurbulence.Equals((float)v))
						{
							v = windTurbulence;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "windPulseMagnitude",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((WindZone)o).windPulseMagnitude = (float)v;
					},
					Getter = (object o) => ((WindZone)o).windPulseMagnitude,
					Updater = delegate(object o, ref object v)
					{
						float windPulseMagnitude = ((WindZone)o).windPulseMagnitude;
						if (!windPulseMagnitude.Equals((float)v))
						{
							v = windPulseMagnitude;
							return true;
						}
						return false;
					}
				},
				new ProximaComponentCommands.PropertyInfo
				{
					Name = "windPulseFrequency",
					PropertyType = typeof(float),
					Setter = (object o, object v) =>
					{
						((WindZone)o).windPulseFrequency = (float)v;
					},
					Getter = (object o) => ((WindZone)o).windPulseFrequency,
					Updater = delegate(object o, ref object v)
					{
						float windPulseFrequency = ((WindZone)o).windPulseFrequency;
						if (!windPulseFrequency.Equals((float)v))
						{
							v = windPulseFrequency;
							return true;
						}
						return false;
					}
				}
			}
		}
	};
}

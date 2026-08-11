using System;
using UnityEngine;
using UnityEngine.Events;

namespace Ase;

[Serializable]
public class UnityEventOnDrag : UnityEvent<HeroSkillTypeEnum, Vector3, bool, bool>
{
}

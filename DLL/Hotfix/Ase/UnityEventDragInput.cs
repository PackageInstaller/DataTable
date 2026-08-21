using System;
using UnityEngine;
using UnityEngine.Events;

namespace Ase;

[Serializable]
public class UnityEventDragInput : UnityEvent<HeroSkillTypeEnum, Vector3>
{
}

using System;
using UnityEngine.Events;

namespace Ase;

[Serializable]
public class UnityEventDescInput : UnityEvent<HeroSkillTypeEnum, bool>
{
}

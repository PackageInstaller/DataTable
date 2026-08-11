using System;
using UnityEngine.Events;

namespace Ase;

[Serializable]
public class UnityEventInteractiveInput : UnityEvent<HeroSkillTypeEnum, int>
{
}

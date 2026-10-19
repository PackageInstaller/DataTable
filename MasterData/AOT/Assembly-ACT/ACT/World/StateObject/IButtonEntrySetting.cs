using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.StateObject;

public interface IButtonEntrySetting : ICommonInteractEntrySetting
{
	bool OpenBoxAni { get; }

	bool MotionLimitButtonInteract { get; }

	LocalizedString LocalizedString { get; }

	int Weight { get; }

	int IconId { get; }

	int TipIcon { get; }

	Transform TipTransform { get; }

	bool ButtonShow { get; set; }
}

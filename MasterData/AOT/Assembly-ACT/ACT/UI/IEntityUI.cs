using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public interface IEntityUI
{
	bool Show { get; set; }

	void Init(Entity entity, bool show, Vector3 eulerAngles);

	void UpdatePos();

	void OnRelease(Action callback = null);
}

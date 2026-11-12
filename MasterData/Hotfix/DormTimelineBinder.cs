using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Animations;

public class DormTimelineBinder : MonoBehaviour
{
	[Serializable]
	public class ConstraintBinding
	{
		public ParentConstraint constraint;

		public string[] sourcePaths;
	}

	public List<ConstraintBinding> bindings = new List<ConstraintBinding>();

	private const string kRootNodeSymbol = "%%ROOT%%";

	public void Retarget(Transform targetRoot)
	{
		for (int i = 0; i < bindings.Count; i++)
		{
			ConstraintBinding constraintBinding = bindings.get_Item(i);
			if (constraintBinding == null || constraintBinding.constraint == null || constraintBinding.sourcePaths == null)
			{
				continue;
			}
			ParentConstraint constraint = constraintBinding.constraint;
			if (constraintBinding.sourcePaths.Length != constraint.sourceCount)
			{
				Debug.LogError($"[DormTimelineBinder] \"{name}\"的约束\"{constraint.name}\"源数量({constraint.sourceCount})与记录({constraintBinding.sourcePaths.Length})不一致", this);
				continue;
			}
			for (int j = 0; j < constraintBinding.sourcePaths.Length; j++)
			{
				string text = constraintBinding.sourcePaths[j];
				if (!string.IsNullOrEmpty(text))
				{
					Transform transform = ((text == "%%ROOT%%") ? targetRoot : targetRoot.Find(text));
					if (transform == null)
					{
						Debug.LogError($"[DormTimelineBinder] \"{name}\"的约束\"{constraint.name}\"第{j}个源骨骼路径\"{text}\"在真身\"{targetRoot.name}\"下未找到", this);
					}
					else
					{
						ConstraintSource source = constraint.GetSource(j);
						source.sourceTransform = transform;
						constraint.SetSource(j, source);
					}
				}
			}
		}
	}
}

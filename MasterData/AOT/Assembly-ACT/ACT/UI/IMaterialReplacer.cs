using UnityEngine;

namespace ACT.UI;

public interface IMaterialReplacer
{
	int order { get; }

	Material Replace(Material material);
}

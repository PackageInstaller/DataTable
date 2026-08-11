using UnityEngine;

namespace Ase;

public class BoardHeroPreviewTransformData
{
	public int BoardHeroId { get; }

	public Vector2 AnchoredPosition { get; }

	public Vector3 LocalScale { get; }

	public Quaternion LocalRotation { get; }

	public BoardHeroPreviewTransformData(int boardHeroId, Vector2 anchoredPosition, Vector3 localScale, Quaternion localRotation)
	{
		BoardHeroId = boardHeroId;
		AnchoredPosition = anchoredPosition;
		LocalScale = localScale;
		LocalRotation = localRotation;
	}
}

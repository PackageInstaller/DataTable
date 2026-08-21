using UnityEngine;

public class RubyData
{
	public int startIndex;

	public int endIndex;

	public int rubyContentStartIndex;

	public int rubyContentEndIndex;

	public string rubyContent;

	public bool isFilled;

	public float totalWidth;

	public float posX;

	public float posY = float.MinValue;

	public Color color = Color.white;

	public RubyData(int startIndex)
	{
		this.startIndex = startIndex;
		isFilled = false;
	}
}

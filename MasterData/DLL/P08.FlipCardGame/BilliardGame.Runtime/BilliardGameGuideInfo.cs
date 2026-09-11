namespace BilliardGame.Runtime;

public class BilliardGameGuideInfo
{
	public float x;

	public float y;

	public bool isGuide;

	public bool isComplete;

	public void Reset()
	{
		x = 0f;
		y = 0f;
		isGuide = false;
		isComplete = false;
	}

	public void SetData(float x, float y)
	{
		this.y = y;
		this.x = x;
		isGuide = true;
		isComplete = false;
	}

	public void FinishGuide()
	{
		isGuide = false;
		isComplete = true;
	}
}

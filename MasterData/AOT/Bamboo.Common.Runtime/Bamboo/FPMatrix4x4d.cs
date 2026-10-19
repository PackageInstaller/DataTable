namespace Bamboo;

public struct FPMatrix4x4d(int i)
{
	public FPFloat[] m = new FPFloat[16];

	public FPFloat this[int index]
	{
		get
		{
			return m[index];
		}
		set
		{
			m[index] = value;
		}
	}

	public FPFloat this[int row, int colum]
	{
		get
		{
			return m[row * 4 + colum];
		}
		set
		{
			m[row * 4 + colum] = value;
		}
	}
}

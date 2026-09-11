namespace civilization;

public class Hero
{
	public int id;

	public int startTech;

	public int[][] hexFactor;

	public Hero(int id, int startTech, int[] hex1, int[] hex2, int[] hex3)
	{
		this.id = id;
		this.startTech = startTech;
		hexFactor = new int[3][] { hex1, hex2, hex3 };
	}
}

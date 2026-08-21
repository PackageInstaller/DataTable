namespace civilization;

public class Stage
{
	public int ID;

	public int activityID;

	public int[] init_cell_list;

	public int[] init_cells_location;

	public int[] init_source;

	public int[] init_factor;

	public int[][] teach_init_list;

	public int[][] teach_create_list;

	public void SetTeachInitList(int[][] teach_init_list_data, int[][] teach_create_list_data)
	{
		teach_init_list = new int[teach_init_list_data.Length][];
		teach_create_list = new int[teach_create_list_data.Length][];
		for (int i = 0; i < teach_init_list_data.Length; i++)
		{
			teach_init_list[i] = new int[4];
			for (int j = 0; j < teach_init_list_data[i].Length; j++)
			{
				teach_init_list[i][j] = teach_init_list_data[i][j];
			}
		}
		for (int k = 0; k < teach_create_list_data.Length; k++)
		{
			teach_create_list[k] = new int[4];
			for (int l = 0; l < teach_create_list_data[k].Length; l++)
			{
				teach_create_list[k][l] = teach_create_list_data[k][l];
			}
		}
	}

	public Stage(int iD, int activityID, int[] init_cell_list, int[] init_cells_location, int[] init_source, int[] init_factor)
	{
		ID = iD;
		this.activityID = activityID;
		this.init_cell_list = init_cell_list;
		this.init_cells_location = init_cells_location;
		this.init_source = init_source;
		this.init_factor = init_factor;
	}
}

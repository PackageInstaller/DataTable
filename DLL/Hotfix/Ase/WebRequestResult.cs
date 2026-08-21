namespace Ase;

public class WebRequestResult
{
	public string _t { get; set; }

	public int code { get; set; }

	public bool status { get; set; }

	public string msg { get; set; }

	public int logicCode { get; set; }

	public string data { get; set; }

	public bool Error()
	{
		bool num = code != 1000 && code != 200;
		bool flag = logicCode != 0;
		return num | flag;
	}
}

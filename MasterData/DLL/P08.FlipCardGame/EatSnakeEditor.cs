using System.Collections.Generic;
using System.IO;
using LitJson;
using UnityEngine;
using UnityEngine.UI;

public class EatSnakeEditor : MonoBehaviour
{
	public struct MapData
	{
		public bool wall;

		public string mapID;

		public List<string> floorData;
	}

	private const string BATTLE_AB_MAP_SNAKE_PATH = "Assets/ComBattle/ABResources/Map/SnakeMap";

	public Button load;

	public Button save;

	public Toggle wall;

	public InputField stage;

	public GameObject map;

	private void Start()
	{
		EatSnakeBlock[] eatSnakeBlocks = map.GetComponentsInChildren<EatSnakeBlock>();
		for (int i = 0; i < eatSnakeBlocks.Length; i++)
		{
			eatSnakeBlocks[i].SetPosition(i / 16, i % 16);
		}
		load.onClick.AddListener(delegate
		{
			string path = Path.Combine("Assets/ComBattle/ABResources/Map/SnakeMap", stage.text + ".txt");
			if (!File.Exists(path))
			{
				Debug.LogError("没有别点了");
			}
			StreamReader streamReader = File.OpenText(path);
			string json = streamReader.ReadToEnd();
			streamReader.Close();
			JsonData jsonData = JsonMapper.ToObject(json);
			IList<JsonData> list = jsonData.toDict()["floorData"].toArray();
			int num = 0;
			wall.isOn = (bool)jsonData.get_Item("wall");
			EatSnakeBlock[] array = eatSnakeBlocks;
			foreach (EatSnakeBlock obj in array)
			{
				string[] array2 = list[num].ToString().Split(",");
				obj.SetData(int.Parse(array2[0]), int.Parse(array2[1]), int.Parse(array2[2]), int.Parse(array2[3]), int.Parse(array2[4]), int.Parse(array2[5]));
				num++;
			}
		});
		save.onClick.AddListener(delegate
		{
			MapData mapData = new MapData
			{
				mapID = stage.text,
				floorData = new List<string>()
			};
			EatSnakeBlock[] array = eatSnakeBlocks;
			foreach (EatSnakeBlock eatSnakeBlock in array)
			{
				string item = $"{eatSnakeBlock.x},{eatSnakeBlock.y},{(int)eatSnakeBlock.type},{eatSnakeBlock.reinforceFointOrder},{eatSnakeBlock.reinforceNeedType},{eatSnakeBlock.reinforceNeedCount}";
				mapData.floorData.Add(item);
			}
			mapData.wall = wall.isOn;
			string value = JsonMapper.ToJson(mapData);
			string path = Path.Combine("Assets/ComBattle/ABResources/Map/SnakeMap", stage.text + ".txt");
			if (File.Exists(path))
			{
				File.Delete(path);
			}
			StreamWriter streamWriter = new StreamWriter(path);
			streamWriter.WriteLine(value);
			streamWriter.Close();
		});
		stage.onEndEdit.AddListener(delegate
		{
		});
		wall.onValueChanged.AddListener(delegate(bool ison)
		{
			Text componentInChildren = wall.GetComponentInChildren<Text>();
			if (ison)
			{
				componentInChildren.text = "have";
			}
			else
			{
				componentInChildren.text = "no";
			}
		});
	}

	private void Update()
	{
	}
}

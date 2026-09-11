using System.Text;

public static class CookingGameBrige
{
	public static void LoadGame(string stepDataName, bool isBattle)
	{
		CookingGameManager.Instance.LoadGame(stepDataName, isBattle);
	}

	public static string GetCookData()
	{
		CookingGameManager instance = CookingGameManager.Instance;
		if (instance == null)
		{
			return "{}";
		}
		CookingGameManager.GameTimeData gameTimeData = instance.GetGameTimeData();
		if (gameTimeData == null)
		{
			return "{}";
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("[");
		foreach (CookingGameManager.StepTimeData step in gameTimeData.steps)
		{
			stringBuilder.AppendFormat("{{\"{0}\",{1},{2},{3}}},", step.stepID, step.successCount, step.failureCount, step.timeSpent.ToString("F2"));
		}
		if (gameTimeData.steps.Count > 0)
		{
			stringBuilder.Length--;
		}
		stringBuilder.Append("]");
		return $"{instance.currentStepID}|{gameTimeData.totalTime:F2}|{stringBuilder}";
	}
}

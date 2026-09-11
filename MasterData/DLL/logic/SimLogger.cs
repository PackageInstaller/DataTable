using Entitas;

public class SimLogger : IInitializeSystem, ISystem, ITearDownSystem
{
	public static SimContext sSimContext;

	public SimLogger(SimContext context)
	{
		sSimContext = context;
	}

	public static void Debug(string param)
	{
		if (sSimContext == null)
		{
			XLogger.Debug(param);
		}
		else
		{
			XLogger.Debug("[SimFrame]" + sSimContext.simStatus.mServerFrame, param);
		}
	}

	public void Initialize()
	{
	}

	public void TearDown()
	{
		sSimContext = null;
	}
}

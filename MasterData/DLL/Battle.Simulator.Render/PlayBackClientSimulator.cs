using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

public class PlayBackClientSimulator : ClientSimulator
{
	public List<Command> cmdList;

	private int currentIndex;

	public bool dontcareStoryCommand;

	public override void SendLocalCommand(Command command)
	{
		if (command is StoryCommand && dontcareStoryCommand)
		{
			command.GetType().GetMethod("BindContext", BindingFlags.Instance | BindingFlags.NonPublic).Invoke(command, new object[1] { mSimContext });
			command.RunCommand(0L);
			command.ReleaseCommand();
		}
		else
		{
			command.ReleaseCommand();
		}
	}

	public void Update()
	{
		if (cmdList == null)
		{
			return;
		}
		uint num = ClientSimulator.Instance.mSimContext.simStatus.mServerFrame;
		if (CommonProcessor.IsMultiplePlayerGameMode(ClientSimulator.Instance.mSimContext))
		{
			num++;
		}
		while (currentIndex < cmdList.Count && num >= cmdList[currentIndex].mFrameCount)
		{
			Command command = cmdList[currentIndex];
			MethodInfo method = command.GetType().GetMethod("BindContext", BindingFlags.Instance | BindingFlags.NonPublic);
			if (method == null)
			{
				Debug.LogError("找不到 BindContext 方法");
			}
			else if (command is StoryCommand && dontcareStoryCommand)
			{
				Debug.LogError(num + ", " + (command as StoryCommand).enterState);
			}
			else
			{
				method.Invoke(command, new object[1] { mSimContext });
				command.RunCommand(0L);
				command.ReleaseCommand();
			}
			currentIndex++;
		}
	}

	protected override SimResultType AdvanceServerSimFrame(uint serverFrame)
	{
		if (CommonProcessor.IsMultiplePlayerGameMode(ClientSimulator.Instance.mSimContext))
		{
			Update();
		}
		SimResultType num = base.AdvanceServerSimFrame(serverFrame);
		if (num == SimResultType.OK && !CommonProcessor.IsMultiplePlayerGameMode(ClientSimulator.Instance.mSimContext))
		{
			Update();
		}
		return num;
	}
}

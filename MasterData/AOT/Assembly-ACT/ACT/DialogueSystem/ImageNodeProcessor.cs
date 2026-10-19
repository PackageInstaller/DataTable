using System.Threading;
using ACT.Drama;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class ImageNodeProcessor : DialogueNodeProcessor<ImageNode>
{
	public class ImageState : DialogueState
	{
		private int m_ImageId;

		private float m_ImageOffset;

		protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
		{
			return Apply();
		}

		public UniTask Update(int imageId, float imageOffset, bool skipping)
		{
			m_ImageId = imageId;
			m_ImageOffset = imageOffset;
			if (!skipping)
			{
				return Apply();
			}
			return UniTask.CompletedTask;
		}

		private UniTask Apply()
		{
			MonoConversationView monoConversationView = Singleton<ConversationManager>.instance?.conversationView;
			if (!monoConversationView)
			{
				return UniTask.CompletedTask;
			}
			return monoConversationView.ImageTask(m_ImageId, m_ImageOffset);
		}
	}

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminContext = context as LuminDialogueContext;
		if (!luminContext.Skipping)
		{
			await LuminDialogueUtility.AwaitConversationView(token);
		}
		await luminContext.States.GetOrCreateState<ImageState>().Update(imageOffset: GetImageOffset(TData.imagePosition, TData.imageOffset), imageId: TData.imageId, skipping: luminContext.Skipping);
		return DialogueNodeResult.Continue;
	}

	private static float GetImageOffset(ChatImagePosition imagePosition, float customOffset)
	{
		return imagePosition switch
		{
			ChatImagePosition.MiddleLeft => -250f, 
			ChatImagePosition.MiddleRight => 250f, 
			ChatImagePosition.Custom => customOffset, 
			_ => 0f, 
		};
	}
}

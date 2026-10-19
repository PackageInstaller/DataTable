using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.Conversation;

public interface IConversationSceneBgFade
{
	UniTask FadeTo(float alpha, float duration, CancellationToken token);
}

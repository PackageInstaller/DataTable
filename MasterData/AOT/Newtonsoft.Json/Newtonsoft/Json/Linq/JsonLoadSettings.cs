namespace Newtonsoft.Json.Linq;

public class JsonLoadSettings
{
	private CommentHandling _commentHandling;

	private LineInfoHandling _lineInfoHandling;

	private DuplicatePropertyNameHandling _duplicatePropertyNameHandling;

	public CommentHandling CommentHandling => _commentHandling;

	public LineInfoHandling LineInfoHandling => _lineInfoHandling;

	public DuplicatePropertyNameHandling DuplicatePropertyNameHandling => _duplicatePropertyNameHandling;
}

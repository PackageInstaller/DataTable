namespace Unity.VisualScripting.Dependencies.NCalc;

public class BinaryExpression : LogicalExpression
{
	public LogicalExpression LeftExpression { get; set; }

	public LogicalExpression RightExpression { get; set; }

	public BinaryExpressionType Type { get; set; }

	public BinaryExpression(BinaryExpressionType type, LogicalExpression leftExpression, LogicalExpression rightExpression)
	{
		Type = type;
		LeftExpression = leftExpression;
		RightExpression = rightExpression;
	}

	public override void Accept(LogicalExpressionVisitor visitor)
	{
		visitor.Visit(this);
	}
}

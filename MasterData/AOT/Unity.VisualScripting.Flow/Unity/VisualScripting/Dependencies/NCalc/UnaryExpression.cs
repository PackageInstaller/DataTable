namespace Unity.VisualScripting.Dependencies.NCalc;

public class UnaryExpression : LogicalExpression
{
	public LogicalExpression Expression { get; set; }

	public UnaryExpressionType Type { get; set; }

	public UnaryExpression(UnaryExpressionType type, LogicalExpression expression)
	{
		Type = type;
		Expression = expression;
	}

	public override void Accept(LogicalExpressionVisitor visitor)
	{
		visitor.Visit(this);
	}
}

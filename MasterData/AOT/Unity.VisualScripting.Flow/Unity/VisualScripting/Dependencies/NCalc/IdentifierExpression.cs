namespace Unity.VisualScripting.Dependencies.NCalc;

public class IdentifierExpression : LogicalExpression
{
	public string Name { get; set; }

	public IdentifierExpression(string name)
	{
		Name = name;
	}

	public override void Accept(LogicalExpressionVisitor visitor)
	{
		visitor.Visit(this);
	}
}

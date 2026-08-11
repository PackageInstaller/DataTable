namespace Ase;

public interface IMathTriggerEventHandler
{
	void OnMathTriggerEnter(MathTriggerEventData eventData);

	void OnMathTriggerExit(MathTriggerEventData eventData);

	void OnMathTriggerStay(MathTriggerEventData eventData);
}

using System.Collections.Generic;
using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Particle Collision", 0)]
[Category("Events/Object")]
[Description("Called when any Particle System collided with the target collider object")]
public class ParticleCollisionEvents : MessageEventNode<Collider>
{
	private FlowOutput onCollision;

	private Collider receiver;

	private ParticleSystem particle;

	private List<ParticleCollisionEvent> collisionEvents;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[1] { "OnParticleCollision" };
	}

	protected override void RegisterPorts()
	{
		onCollision = AddFlowOutput("On Particle Collision");
		AddValueOutput("Receiver", () => receiver);
		AddValueOutput("Particle System", () => particle);
		AddValueOutput("Collision Point", () => collisionEvents[0].intersection);
		AddValueOutput("Collision Normal", () => collisionEvents[0].normal);
		AddValueOutput("Collision Velocity", () => collisionEvents[0].velocity);
	}

	private void OnParticleCollision(MessageRouter.MessageData<GameObject> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		particle = msg.value.GetComponent<ParticleSystem>();
		collisionEvents = new List<ParticleCollisionEvent>();
		if (particle != null)
		{
			particle.GetCollisionEvents(receiver.gameObject, collisionEvents);
		}
		onCollision.Call(default(Flow));
	}
}

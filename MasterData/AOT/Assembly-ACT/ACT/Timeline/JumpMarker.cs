using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[DisplayName("JumpMarker")]
public class JumpMarker : Marker, INotification, INotificationOptionProvider
{
	public PropertyName id => new PropertyName(name);

	public NotificationFlags flags => (NotificationFlags)0;
}

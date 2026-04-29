HomePetInteractCameraState = {
  None = 0,
  RotatePetAndMoveCamera = 1,
  RoatateCameraAndZ = 2,
  PlayStory = 3,
  RotatePetAndRevertInteractCamera = 4,
  EndInteract = 5,
  RevertStoryCamera = 6,
  GetRewards = 7,
  OpenTouch = 8,
  EndStory = 9
}
_enum("HomePetInteractCameraState", HomePetInteractCameraState)
HomePetInteractState = {
  None = 0,
  BeginInteract = 1,
  EndInteract = 2,
  BeginStory = 3,
  Storying = 4,
  EndStory = 5,
  Close = 6
}
_enum("HomePetInteractState", HomePetInteractState)

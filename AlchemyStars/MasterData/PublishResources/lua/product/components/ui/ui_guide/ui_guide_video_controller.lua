LuaS �

xV           (w@V@../PublishResources/lua/product/components/ui/ui_guide/ui_guide_video_controller.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@�� B l@ 
@��& � 
   _classUIGuideVideoControllerUIControllerLoadDataOnEnterOnShowUpdateInitWidget_LoadVideoUIGuideVideoControllerExitBtnOnClick           	       � @C� �@�& �    SetSucc                    	      self       TT       res               #       � @ �@ �@@ ��@��� �� � � �@    ��   AAL�A � dA��   @�
 GAB L���� dA���GAB L���  dA�L�B �  dA�& �    InitWidgetCfg
cfg_video              
VideoName_LoadVideo_startCheck exitGo
SetActive
StartTask            !    
   F @ G@� b@  � �F�� �   d@ �� ��& �    _videoPlayer
isPlayingYIELD_startCheck          
                               !      TT    
      self_ENV                                                                                    !      #      self       	uiParams       cfg      	freeExit
      
videoName         _ENV %   .       G @ b@    �& � G@@ b@  ��G�@ G�� b@  ��
 ��G�@ L@� d@ G�A L�� � � d@�& �    _startCheck_finish_videoPlayer
isPlayingPauseexitGo
SetActive           &   &   &   '   )   )   )   )   )   )   )   *   +   +   +   ,   ,   ,   ,   .      self            1   >    !   L@@ ��  �  d� 
@ �L@@ �@ �  d� 
@ �F�A G � L@� �� � A d��
@ �G A ��A J���G @ ��A J� �L D �@ d��
@��G�C L�� �   d@�& �    _videoPlayerGetUIComponentVideoPlayervideoPlayer
_rawImage	RawImage_rtUnityEngineRenderTextureNew�      %             texturetargetTextureexitGoGetGameObjectexit
SetActive         !   3   3   3   3   3   5   5   5   5   5   7   7   7   7   7   7   7   7   8   8   8   9   9   9   <   <   <   <   =   =   =   =   >      self    !      _ENV @   L    ,   � @ �@@�� ��@ � A�  AFA GA��� ƀA ��� @ �@��@B ǀ����C� �@��@B ʀ ��@B ʀÆ�@B D AD$�� �D�� $��� ���@B � ��@ � D �@�䀀 ̀�A� 䀀�@��@ & �    ResourceManagerGetInstanceGetAssetPath.mp4	LoadType
VideoClipLogdebug[guide movie] move url _videoPlayergameObject
SetActiveurl
isLooping targetCameraGameGlobalUIStateManagerGetControllerCameraUIGuideVideoControllerPlayRender         ,   A   A   A   A   A   A   A   A   A   A   B   B   B   B   B   D   D   D   D   D   E   E   F   F   G   G   G   G   G   G   G   G   H   H   H   K   K   K   K   K   K   K   K   L      self    ,   
videoName    ,   url
   ,      _ENV O   Q       � @ �@ & �    CloseDialog           P   P   Q      self       go                                   	         #      %   .   %   1   >   1   @   L   @   O   Q   O   Q          _ENV
LuaS �

xV           (w@P@../PublishResources/config/shared/skill/skill_view/cfg_skill_view_53520414.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               n PlayCasterBindEffect,effectID=200360102; PlayCasterAnimation,animName = Birth; PlayCasterVisible,visible=1; �2       Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; PlayTargetAddBuff,buffID=PARAM.buffID2; PlayTargetAddBuff,buffID=PARAM.buffID3; PlayTargetAddBuff,buffID=PARAM.buffID4; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop;         %                                                                                                                     key   %   config    %      _ENV
LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2905301/cfg_skill_view_290530400.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ��       PlayAudio,audioID=6295,audioType=1; PlayCameraEffect,effectID=290530102; PlayCameraEffect,effectID=290530104; PlayCasterAnimation,animName=Transform_b; PlayCasterMaterialAnim,animName=eff_2902201_transform_mat; Wait,waitTime=350; PlayCasterBindEffect,effectID=290220113; Wait,waitTime=200; PlayTeamHUDVisible,visible=0; PlayCasterControlOutLine,enable=0; PlayCasterControlGridDown,enable=0; PlayCasterHUDVisible,visible=0; Wait,waitTime=1700; PlayTransformation; PlayTeamHUDVisible,visible=1; PlayCasterControlOutLine,enable=1; PlayCasterControlGridDown,enable=1; PlaySwitchBodyAreaResult; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=290530103; PlayCasterMaterialAnim,animName=eff_2905301_transform_mat; Wait,waitTime=1000; �      � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop;         %                                                                                                                     key   %   config    %      _ENV
LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2906101/cfg_skill_view_290610104.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ��       PlayAudio,audioID=7070,audioType=1; PlayCasterAnimation,animName=Skill04; PlayCasterBindEffect,effectID =290610113; PlayCasterBindEffect,effectID =290610114; PlayCasterMaterialAnim,animName=PARAM.animName; Wait,waitTime=1900; DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0; DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0; Jump,condition=CheckTargetHPAndSceneState,param=1|2802402|50,result=0,goto=phaseEnd; PlaySetSceneObjVisible,sceneObjName=qgfxcq_gate_01,visible=0; PlaySetSceneObjVisible,sceneObjName=qgfxcq_gate_02,visible=1; � Jump,condition=CheckTargetHPAndSceneState,param=2|2802402|0,result=0,goto=phaseEnd; PlaySetSceneObjVisible,sceneObjName=qgfxcq_gate_02,visible=0; PlaySetSceneObjVisible,sceneObjName=qgfxcq_gate_03,visible=1;         %                                                                                                                     key   %   config    %      _ENV
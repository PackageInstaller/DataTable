return {
	Play109081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109081001
		arg_1_1.duration_ = 5.3

		local var_1_0 = {
			ja = 3.799999999999,
			ko = 4.7,
			zh = 5.3,
			en = 3.966
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play109081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C07_1 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C07_1")
				var_4_0.name = "C07_1"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C07_1 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C07_1

				arg_1_1.bgs_.C07_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C07_1" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.C07_1:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueC07_1 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueC07_1 = var_4_4
				end

				arg_1_1.var_.alphaOldValueC07_1 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueC07_1 then
					arg_1_1.var_.alphaMatValueC07_1.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueC07_1, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueC07_1.color = arg_1_1.var_.alphaMatValueC07_1.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueC07_1 then
				arg_1_1.var_.alphaMatValueC07_1.color.a = 1
				arg_1_1.var_.alphaMatValueC07_1.color = arg_1_1.var_.alphaMatValueC07_1.color
			end

			local var_4_6 = "3004_tpose"

			if arg_1_1.actors_["3004_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3004_tpose"))) then
				local var_4_7 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_1_1.stage_.transform)

				var_4_7.name = var_4_6
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_6] = var_4_7

				local var_4_8 = var_4_7:GetComponentInChildren(typeof(CharacterEffect))

				var_4_8.enabled = true

				local var_4_9 = GameObjectTools.GetOrAddComponent(var_4_7, typeof(DynamicBoneHelper))

				if var_4_9 then
					var_4_9:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_8.transform, false)

				arg_1_1.var_[var_4_6 .. "Animator"] = var_4_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_6 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_6 .. "LipSync"] = var_4_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_10 = arg_1_1.actors_["3004_tpose"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos3004_tpose = var_4_10.localPosition

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_10.gameObject, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end
			end

			local var_4_12 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_12 then
				var_4_10.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos3004_tpose, Vector3.New(-0.7, -2.22, -3.1), (arg_1_1.time_ - 1.8) / var_4_12)
				var_4_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_10.position).x, (manager.ui.mainCamera.transform.position - var_4_10.position).y, (manager.ui.mainCamera.transform.position - var_4_10.position).z)
				var_4_10.localEulerAngles.z = 0
				var_4_10.localEulerAngles.x = 0
				var_4_10.localEulerAngles = var_4_10.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_12 and arg_1_1.time_ < 1.8 + var_4_12 + arg_4_0 then
				var_4_10.localPosition = Vector3.New(-0.7, -2.22, -3.1)
				var_4_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_10.position).x, (manager.ui.mainCamera.transform.position - var_4_10.position).y, (manager.ui.mainCamera.transform.position - var_4_10.position).z)
				var_4_10.localEulerAngles.z = 0
				var_4_10.localEulerAngles.x = 0
				var_4_10.localEulerAngles = var_4_10.localEulerAngles

				local var_4_13 = GameObjectTools.GetOrAddComponent(var_4_10.gameObject, typeof(DynamicBoneHelper))

				if var_4_13 then
					var_4_13:EnableDynamicBone(true)
				end
			end

			local var_4_14 = arg_1_1.actors_["3004_tpose"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect3004_tpose == nil then
				arg_1_1.var_.characterEffect3004_tpose = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect3004_tpose and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect3004_tpose then
				arg_1_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_20 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_20 + 2 and arg_1_1.time_ < var_4_20 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 2
			local var_4_22 = 0.175

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_24 = arg_1_1:GetWordFromCfg(109081001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 7 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 7)

				if (7 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 7)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081001", "story_v_out_109081.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_109081", "109081001", "story_v_out_109081.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_109081", "109081001", "story_v_out_109081.awb")

						arg_1_1:RecordAudio("109081001", var_4_29)
						arg_1_1:RecordAudio("109081001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_109081", "109081001", "story_v_out_109081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_109081", "109081001", "story_v_out_109081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play109081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109081002
		arg_8_1.duration_ = 2

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play109081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["3004_tpose"]) and arg_8_1.var_.characterEffect3004_tpose == nil then
				arg_8_1.var_.characterEffect3004_tpose = arg_8_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["3004_tpose"]) then
				if arg_8_1.var_.characterEffect3004_tpose and not isNil(arg_8_1.actors_["3004_tpose"]) then
					arg_8_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_8_1.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["3004_tpose"]) and arg_8_1.var_.characterEffect3004_tpose then
				arg_8_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_8_1.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			local var_11_1 = "10004ui_story"

			if arg_8_1.actors_["10004ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10004ui_story"))) then
				local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "10004ui_story"), arg_8_1.stage_.transform)

				var_11_2.name = var_11_1
				var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_[var_11_1] = var_11_2

				local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

				var_11_3.enabled = true

				local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

				if var_11_4 then
					var_11_4:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_3.transform, false)

				arg_8_1.var_[var_11_1 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_[var_11_1 .. "Animator"].applyRootMotion = true
				arg_8_1.var_[var_11_1 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_5 = arg_8_1.actors_["10004ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect10004ui_story == nil then
				arg_8_1.var_.characterEffect10004ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.characterEffect10004ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect10004ui_story then
				arg_8_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_11_8 = arg_8_1.actors_["10004ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos10004ui_story = var_11_8.localPosition
			end

			local var_11_9 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_9 then
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10004ui_story, Vector3.New(0.7, -1.1, -5.6), (arg_8_1.time_ - 0) / var_11_9)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_9 and arg_8_1.time_ < 0 + var_11_9 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(0.7, -1.1, -5.6)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action1_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_11_10 = 0
			local var_11_11 = 0.075

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(109081002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 3 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 3)

				if (3 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 3)) > 0 and var_11_11 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081002", "story_v_out_109081.awb") ~= 0 then
					local var_11_16 = manager.audio:GetVoiceLength("story_v_out_109081", "109081002", "story_v_out_109081.awb") / 1000

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_109081", "109081002", "story_v_out_109081.awb")

						arg_8_1:RecordAudio("109081002", var_11_17)
						arg_8_1:RecordAudio("109081002", var_11_17)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_109081", "109081002", "story_v_out_109081.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_109081", "109081002", "story_v_out_109081.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_18 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_18 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_18

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_18 and arg_8_1.time_ < var_11_10 + var_11_18 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play109081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109081003
		arg_12_1.duration_ = 8.47

		local var_12_0 = {
			ja = 4.133,
			ko = 4.066,
			zh = 8.466,
			en = 3.933
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play109081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["3004_tpose"]) and arg_12_1.var_.characterEffect3004_tpose == nil then
				arg_12_1.var_.characterEffect3004_tpose = arg_12_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["3004_tpose"]) then
				if arg_12_1.var_.characterEffect3004_tpose and not isNil(arg_12_1.actors_["3004_tpose"]) then
					arg_12_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["3004_tpose"]) and arg_12_1.var_.characterEffect3004_tpose then
				arg_12_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_15_2 = arg_12_1.actors_["10004ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect10004ui_story == nil then
				arg_12_1.var_.characterEffect10004ui_story = var_15_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_3 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 and not isNil(var_15_2) then
				if arg_12_1.var_.characterEffect10004ui_story and not isNil(var_15_2) then
					arg_12_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_12_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_3)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect10004ui_story then
				arg_12_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_12_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_15_4 = 0
			local var_15_5 = 0.35

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_6 = arg_12_1:GetWordFromCfg(109081003)
				local var_15_7 = arg_12_1:FormatText(var_15_6.content)

				arg_12_1.text_.text = var_15_7

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_9 = 14 <= 0 and var_15_5 or var_15_5 * (utf8.len(var_15_7) / 14)

				if (14 <= 0 and var_15_5 or var_15_5 * (utf8.len(var_15_7) / 14)) > 0 and var_15_5 < var_15_9 then
					arg_12_1.talkMaxDuration = var_15_9

					if var_15_9 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_4
					end
				end

				arg_12_1.text_.text = var_15_7
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081003", "story_v_out_109081.awb") ~= 0 then
					local var_15_10 = manager.audio:GetVoiceLength("story_v_out_109081", "109081003", "story_v_out_109081.awb") / 1000

					if var_15_10 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_4
					end

					if var_15_6.prefab_name ~= "" and arg_12_1.actors_[var_15_6.prefab_name] ~= nil then
						local var_15_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_6.prefab_name].transform, "story_v_out_109081", "109081003", "story_v_out_109081.awb")

						arg_12_1:RecordAudio("109081003", var_15_11)
						arg_12_1:RecordAudio("109081003", var_15_11)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109081", "109081003", "story_v_out_109081.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109081", "109081003", "story_v_out_109081.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_12 = math.max(var_15_5, arg_12_1.talkMaxDuration)

			if var_15_4 <= arg_12_1.time_ and arg_12_1.time_ < var_15_4 + var_15_12 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_4) / var_15_12

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_4 + var_15_12 and arg_12_1.time_ < var_15_4 + var_15_12 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play109081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109081004
		arg_16_1.duration_ = 6.13

		local var_16_0 = {
			ja = 5.933,
			ko = 6.133,
			zh = 5.533,
			en = 5.733
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play109081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos3004_tpose = arg_16_1.actors_["3004_tpose"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).z)
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles = arg_16_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).z)
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles = arg_16_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = arg_16_1.actors_["10004ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10004ui_story = var_19_3.localPosition
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10004ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, 100, 0)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			local var_19_5 = "1099ui_story"

			if arg_16_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_19_6 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_16_1.stage_.transform)

				var_19_6.name = var_19_5
				var_19_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_[var_19_5] = var_19_6

				local var_19_7 = var_19_6:GetComponentInChildren(typeof(CharacterEffect))

				var_19_7.enabled = true

				local var_19_8 = GameObjectTools.GetOrAddComponent(var_19_6, typeof(DynamicBoneHelper))

				if var_19_8 then
					var_19_8:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_7.transform, false)

				arg_16_1.var_[var_19_5 .. "Animator"] = var_19_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_[var_19_5 .. "Animator"].applyRootMotion = true
				arg_16_1.var_[var_19_5 .. "LipSync"] = var_19_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_9 = arg_16_1.actors_["1099ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1099ui_story = var_19_9.localPosition
			end

			local var_19_10 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_10 then
				var_19_9.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1099ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_16_1.time_ - 0) / var_19_10)
				var_19_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_9.position).x, (manager.ui.mainCamera.transform.position - var_19_9.position).y, (manager.ui.mainCamera.transform.position - var_19_9.position).z)
				var_19_9.localEulerAngles.z = 0
				var_19_9.localEulerAngles.x = 0
				var_19_9.localEulerAngles = var_19_9.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_10 and arg_16_1.time_ < 0 + var_19_10 + arg_19_0 then
				var_19_9.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_19_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_9.position).x, (manager.ui.mainCamera.transform.position - var_19_9.position).y, (manager.ui.mainCamera.transform.position - var_19_9.position).z)
				var_19_9.localEulerAngles.z = 0
				var_19_9.localEulerAngles.x = 0
				var_19_9.localEulerAngles = var_19_9.localEulerAngles
			end

			local var_19_11 = arg_16_1.actors_["1099ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect1099ui_story == nil then
				arg_16_1.var_.characterEffect1099ui_story = var_19_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_12 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_12 and not isNil(var_19_11) then
				if arg_16_1.var_.characterEffect1099ui_story and not isNil(var_19_11) then
					arg_16_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_12 and arg_16_1.time_ < 0 + var_19_12 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect1099ui_story then
				arg_16_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_19_14 = 0
			local var_19_15 = 0.8

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_16 = arg_16_1:GetWordFromCfg(109081004)
				local var_19_17 = arg_16_1:FormatText(var_19_16.content)

				arg_16_1.text_.text = var_19_17

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_19 = 32 <= 0 and var_19_15 or var_19_15 * (utf8.len(var_19_17) / 32)

				if (32 <= 0 and var_19_15 or var_19_15 * (utf8.len(var_19_17) / 32)) > 0 and var_19_15 < var_19_19 then
					arg_16_1.talkMaxDuration = var_19_19

					if var_19_19 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_19 + var_19_14
					end
				end

				arg_16_1.text_.text = var_19_17
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081004", "story_v_out_109081.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_109081", "109081004", "story_v_out_109081.awb") / 1000

					if var_19_20 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_14
					end

					if var_19_16.prefab_name ~= "" and arg_16_1.actors_[var_19_16.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_16.prefab_name].transform, "story_v_out_109081", "109081004", "story_v_out_109081.awb")

						arg_16_1:RecordAudio("109081004", var_19_21)
						arg_16_1:RecordAudio("109081004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109081", "109081004", "story_v_out_109081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109081", "109081004", "story_v_out_109081.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_15, arg_16_1.talkMaxDuration)

			if var_19_14 <= arg_16_1.time_ and arg_16_1.time_ < var_19_14 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_14) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_14 + var_19_22 and arg_16_1.time_ < var_19_14 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play109081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109081005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play109081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1099ui_story"]) and arg_20_1.var_.characterEffect1099ui_story == nil then
				arg_20_1.var_.characterEffect1099ui_story = arg_20_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1099ui_story"]) then
				if arg_20_1.var_.characterEffect1099ui_story and not isNil(arg_20_1.actors_["1099ui_story"]) then
					arg_20_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1099ui_story"]) and arg_20_1.var_.characterEffect1099ui_story then
				arg_20_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_23_1 = "1050ui_story"

			if arg_20_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_20_1.stage_.transform)

				var_23_2.name = var_23_1
				var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_[var_23_1] = var_23_2

				local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

				var_23_3.enabled = true

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_3.transform, false)

				arg_20_1.var_[var_23_1 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_[var_23_1 .. "Animator"].applyRootMotion = true
				arg_20_1.var_[var_23_1 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_5 = arg_20_1.actors_["1050ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1050ui_story == nil then
				arg_20_1.var_.characterEffect1050ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 and not isNil(var_23_5) then
				if arg_20_1.var_.characterEffect1050ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1050ui_story then
				arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_23_8 = arg_20_1.actors_["1050ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1050ui_story = var_23_8.localPosition

				arg_20_1:ShowWeapon(arg_20_1.var_["1050ui_story" .. "Animator"].transform, true)
			end

			local var_23_9 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 then
				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1050ui_story, Vector3.New(0.7, -1, -6.1), (arg_20_1.time_ - 0) / var_23_9)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(0.7, -1, -6.1)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_23_10 = 0
			local var_23_11 = 0.15

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_12 = arg_20_1:GetWordFromCfg(109081005)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 6 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 6)

				if (6 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 6)) > 0 and var_23_11 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081005", "story_v_out_109081.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_out_109081", "109081005", "story_v_out_109081.awb") / 1000

					if var_23_16 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_10
					end

					if var_23_12.prefab_name ~= "" and arg_20_1.actors_[var_23_12.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_12.prefab_name].transform, "story_v_out_109081", "109081005", "story_v_out_109081.awb")

						arg_20_1:RecordAudio("109081005", var_23_17)
						arg_20_1:RecordAudio("109081005", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_109081", "109081005", "story_v_out_109081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_109081", "109081005", "story_v_out_109081.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_18 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_18 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_18

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_18 and arg_20_1.time_ < var_23_10 + var_23_18 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play109081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109081006
		arg_24_1.duration_ = 6.6

		local var_24_0 = {
			ja = 6.6,
			ko = 2.933,
			zh = 4.633,
			en = 3.5
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play109081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1099ui_story"]) and arg_24_1.var_.characterEffect1099ui_story == nil then
				arg_24_1.var_.characterEffect1099ui_story = arg_24_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1099ui_story"]) then
				if arg_24_1.var_.characterEffect1099ui_story and not isNil(arg_24_1.actors_["1099ui_story"]) then
					arg_24_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1099ui_story"]) and arg_24_1.var_.characterEffect1099ui_story then
				arg_24_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_27_1 = arg_24_1.actors_["1050ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1050ui_story == nil then
				arg_24_1.var_.characterEffect1050ui_story = var_27_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_2 and not isNil(var_27_1) then
				if arg_24_1.var_.characterEffect1050ui_story and not isNil(var_27_1) then
					arg_24_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_2)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_2 and arg_24_1.time_ < 0 + var_27_2 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1050ui_story then
				arg_24_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_27_3 = 0
			local var_27_4 = 0.45

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_3 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_5 = arg_24_1:GetWordFromCfg(109081006)
				local var_27_6 = arg_24_1:FormatText(var_27_5.content)

				arg_24_1.text_.text = var_27_6

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_8 = 18 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 18)

				if (18 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 18)) > 0 and var_27_4 < var_27_8 then
					arg_24_1.talkMaxDuration = var_27_8

					if var_27_8 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_3
					end
				end

				arg_24_1.text_.text = var_27_6
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081006", "story_v_out_109081.awb") ~= 0 then
					local var_27_9 = manager.audio:GetVoiceLength("story_v_out_109081", "109081006", "story_v_out_109081.awb") / 1000

					if var_27_9 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_3
					end

					if var_27_5.prefab_name ~= "" and arg_24_1.actors_[var_27_5.prefab_name] ~= nil then
						local var_27_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_5.prefab_name].transform, "story_v_out_109081", "109081006", "story_v_out_109081.awb")

						arg_24_1:RecordAudio("109081006", var_27_10)
						arg_24_1:RecordAudio("109081006", var_27_10)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109081", "109081006", "story_v_out_109081.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109081", "109081006", "story_v_out_109081.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_11 = math.max(var_27_4, arg_24_1.talkMaxDuration)

			if var_27_3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_3 + var_27_11 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_3) / var_27_11

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_3 + var_27_11 and arg_24_1.time_ < var_27_3 + var_27_11 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play109081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109081007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play109081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1050ui_story = arg_28_1.actors_["1050ui_story"].transform.localPosition

				arg_28_1:ShowWeapon(arg_28_1.var_["1050ui_story" .. "Animator"].transform, true)
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1050ui_story"].transform.position).z)
				arg_28_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1050ui_story"].transform.localEulerAngles = arg_28_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1050ui_story"].transform.position).z)
				arg_28_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1050ui_story"].transform.localEulerAngles = arg_28_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_31_1 = arg_28_1.actors_["1099ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1099ui_story = var_31_1.localPosition
			end

			local var_31_2 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 then
				var_31_1.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_2)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 then
				var_31_1.localPosition = Vector3.New(0, 100, 0)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			local var_31_3 = 0
			local var_31_4 = 0.375

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_5 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_5:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(109081007).content)

				arg_28_1.text_.text = var_31_6

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_8 = 15 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_6) / 15)

				if (15 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_6) / 15)) > 0 and var_31_4 < var_31_8 then
					arg_28_1.talkMaxDuration = var_31_8
					var_31_3 = var_31_3 + 0.3

					if var_31_8 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_3
					end
				end

				arg_28_1.text_.text = var_31_6
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_9 = var_31_3 + 0.3
			local var_31_10 = math.max(var_31_4, arg_28_1.talkMaxDuration)

			if var_31_3 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_9) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play109081008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 109081008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play109081009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0.866666666666667 < arg_34_1.time_ and arg_34_1.time_ <= 0.866666666666667 + arg_37_0 then
				arg_34_1.var_.shakeOldPosC07_1 = manager.ui.mainCamera.transform.localPosition
			end

			local var_37_0 = 0.6

			if 0.866666666666667 <= arg_34_1.time_ and arg_34_1.time_ < 0.866666666666667 + var_37_0 then
				local var_37_1, var_37_2 = math.modf((arg_34_1.time_ - 0.866666666666667) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_37_2 * 0.13, var_37_2 * 0.13, var_37_2 * 0.13) + arg_34_1.var_.shakeOldPosC07_1
			end

			if arg_34_1.time_ >= 0.866666666666667 + var_37_0 and arg_34_1.time_ < 0.866666666666667 + var_37_0 + arg_37_0 then
				manager.ui.mainCamera.transform.localPosition = arg_34_1.var_.shakeOldPosC07_1
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:AudioAction("play", "effect", "se_story_9", "se_story_9_shock", "")
			end

			if 0.466666666666667 < arg_34_1.time_ and arg_34_1.time_ <= 0.466666666666667 + arg_37_0 then
				arg_34_1:AudioAction("play", "effect", "se_story_9", "se_story_9_shock02_loop", "")
			end

			local var_37_5 = 0
			local var_37_6 = 1.15

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_7 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(109081008).content)

				arg_34_1.text_.text = var_37_7

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_9 = 46 <= 0 and var_37_6 or var_37_6 * (utf8.len(var_37_7) / 46)

				if (46 <= 0 and var_37_6 or var_37_6 * (utf8.len(var_37_7) / 46)) > 0 and var_37_6 < var_37_9 then
					arg_34_1.talkMaxDuration = var_37_9

					if var_37_9 + var_37_5 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_5
					end
				end

				arg_34_1.text_.text = var_37_7
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_6, arg_34_1.talkMaxDuration)

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_5) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_5 + var_37_10 and arg_34_1.time_ < var_37_5 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play109081009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 109081009
		arg_38_1.duration_ = 5.47

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play109081010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0.466666666666667 < arg_38_1.time_ and arg_38_1.time_ <= 0.466666666666667 + arg_41_0 then
				arg_38_1.var_.shakeOldPosC07_1 = arg_38_1.bgs_.C07_1.transform.localPosition
			end

			local var_41_0 = 5

			if 0.466666666666667 <= arg_38_1.time_ and arg_38_1.time_ < 0.466666666666667 + var_41_0 then
				local var_41_1, var_41_2 = math.modf((arg_38_1.time_ - 0.466666666666667) / 0.099)

				arg_38_1.bgs_.C07_1.transform.localPosition = Vector3.New(var_41_2 * 0.5, var_41_2 * 0.5, var_41_2 * 0) + arg_38_1.var_.shakeOldPosC07_1
			end

			if arg_38_1.time_ >= 0.466666666666667 + var_41_0 and arg_38_1.time_ < 0.466666666666667 + var_41_0 + arg_41_0 then
				arg_38_1.bgs_.C07_1.transform.localPosition = arg_38_1.var_.shakeOldPosC07_1
			end

			local var_41_3 = 0
			local var_41_4 = 0.925

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_3 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_5 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(109081009).content)

				arg_38_1.text_.text = var_41_5

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_7 = 37 <= 0 and var_41_4 or var_41_4 * (utf8.len(var_41_5) / 37)

				if (37 <= 0 and var_41_4 or var_41_4 * (utf8.len(var_41_5) / 37)) > 0 and var_41_4 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_3 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_3
					end
				end

				arg_38_1.text_.text = var_41_5
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_8 = math.max(var_41_4, arg_38_1.talkMaxDuration)

			if var_41_3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_3 + var_41_8 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_3) / var_41_8

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_3 + var_41_8 and arg_38_1.time_ < var_41_3 + var_41_8 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play109081010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 109081010
		arg_42_1.duration_ = 2

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play109081011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1050ui_story = arg_42_1.actors_["1050ui_story"].transform.localPosition

				arg_42_1:ShowWeapon(arg_42_1.var_["1050ui_story" .. "Animator"].transform, false)
			end

			local var_45_0 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 then
				arg_42_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_42_1.time_ - 0) / var_45_0)
				arg_42_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1050ui_story"].transform.position).z)
				arg_42_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["1050ui_story"].transform.localEulerAngles = arg_42_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 then
				arg_42_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.1)
				arg_42_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1050ui_story"].transform.position).z)
				arg_42_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["1050ui_story"].transform.localEulerAngles = arg_42_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_45_1 = manager.ui.mainCamera.transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.shakeOldPosC07_1 = var_45_1.localPosition
			end

			local var_45_2 = 0.6

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_2 then
				local var_45_3, var_45_4 = math.modf((arg_42_1.time_ - 0) / 0.066)

				var_45_1.localPosition = Vector3.New(var_45_4 * 0.13, var_45_4 * 0.13, var_45_4 * 0.13) + arg_42_1.var_.shakeOldPosC07_1
			end

			if arg_42_1.time_ >= 0 + var_45_2 and arg_42_1.time_ < 0 + var_45_2 + arg_45_0 then
				var_45_1.localPosition = arg_42_1.var_.shakeOldPosC07_1
			end

			local var_45_5 = arg_42_1.actors_["1050ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect1050ui_story == nil then
				arg_42_1.var_.characterEffect1050ui_story = var_45_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_6 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_6 and not isNil(var_45_5) then
				if arg_42_1.var_.characterEffect1050ui_story and not isNil(var_45_5) then
					arg_42_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_6 and arg_42_1.time_ < 0 + var_45_6 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect1050ui_story then
				arg_42_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_45_8 = 0
			local var_45_9 = 0.15

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_10 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_10:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_11 = arg_42_1:GetWordFromCfg(109081010)
				local var_45_12 = arg_42_1:FormatText(var_45_11.content)

				arg_42_1.text_.text = var_45_12

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_14 = 6 <= 0 and var_45_9 or var_45_9 * (utf8.len(var_45_12) / 6)

				if (6 <= 0 and var_45_9 or var_45_9 * (utf8.len(var_45_12) / 6)) > 0 and var_45_9 < var_45_14 then
					arg_42_1.talkMaxDuration = var_45_14
					var_45_8 = var_45_8 + 0.3

					if var_45_14 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_8
					end
				end

				arg_42_1.text_.text = var_45_12
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081010", "story_v_out_109081.awb") ~= 0 then
					local var_45_15 = manager.audio:GetVoiceLength("story_v_out_109081", "109081010", "story_v_out_109081.awb") / 1000

					if var_45_15 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_15 + var_45_8
					end

					if var_45_11.prefab_name ~= "" and arg_42_1.actors_[var_45_11.prefab_name] ~= nil then
						local var_45_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_11.prefab_name].transform, "story_v_out_109081", "109081010", "story_v_out_109081.awb")

						arg_42_1:RecordAudio("109081010", var_45_16)
						arg_42_1:RecordAudio("109081010", var_45_16)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_109081", "109081010", "story_v_out_109081.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_109081", "109081010", "story_v_out_109081.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_17 = var_45_8 + 0.3
			local var_45_18 = math.max(var_45_9, arg_42_1.talkMaxDuration)

			if var_45_8 + 0.3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_17 + var_45_18 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_17) / var_45_18

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_17 + var_45_18 and arg_42_1.time_ < var_45_17 + var_45_18 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play109081011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109081011
		arg_48_1.duration_ = 3.47

		local var_48_0 = {
			ja = 2.766,
			ko = 2.5,
			zh = 3.466,
			en = 2.633
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play109081012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1099ui_story = arg_48_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1099ui_story"].transform.position).z)
				arg_48_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1099ui_story"].transform.localEulerAngles = arg_48_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_48_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1099ui_story"].transform.position).z)
				arg_48_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1099ui_story"].transform.localEulerAngles = arg_48_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_51_1 = arg_48_1.actors_["1099ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1099ui_story == nil then
				arg_48_1.var_.characterEffect1099ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect1099ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1099ui_story then
				arg_48_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1050ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1050ui_story == nil then
				arg_48_1.var_.characterEffect1050ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_5 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 and not isNil(var_51_4) then
				if arg_48_1.var_.characterEffect1050ui_story and not isNil(var_51_4) then
					arg_48_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_5)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1050ui_story then
				arg_48_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_51_6 = arg_48_1.bgs_.C07_1.transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.shakeOldPosC07_1 = var_51_6.localPosition
			end

			local var_51_7 = 2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				local var_51_8, var_51_9 = math.modf((arg_48_1.time_ - 0) / 0.099)

				var_51_6.localPosition = Vector3.New(var_51_9 * 0.1, var_51_9 * 0.1, var_51_9 * 0) + arg_48_1.var_.shakeOldPosC07_1
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				var_51_6.localPosition = arg_48_1.var_.shakeOldPosC07_1
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_10 = 0
			local var_51_11 = 0.35

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_12 = arg_48_1:GetWordFromCfg(109081011)
				local var_51_13 = arg_48_1:FormatText(var_51_12.content)

				arg_48_1.text_.text = var_51_13

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 14 <= 0 and var_51_11 or var_51_11 * (utf8.len(var_51_13) / 14)

				if (14 <= 0 and var_51_11 or var_51_11 * (utf8.len(var_51_13) / 14)) > 0 and var_51_11 < var_51_15 then
					arg_48_1.talkMaxDuration = var_51_15

					if var_51_15 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_15 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_13
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081011", "story_v_out_109081.awb") ~= 0 then
					local var_51_16 = manager.audio:GetVoiceLength("story_v_out_109081", "109081011", "story_v_out_109081.awb") / 1000

					if var_51_16 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_16 + var_51_10
					end

					if var_51_12.prefab_name ~= "" and arg_48_1.actors_[var_51_12.prefab_name] ~= nil then
						local var_51_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_12.prefab_name].transform, "story_v_out_109081", "109081011", "story_v_out_109081.awb")

						arg_48_1:RecordAudio("109081011", var_51_17)
						arg_48_1:RecordAudio("109081011", var_51_17)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_109081", "109081011", "story_v_out_109081.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_109081", "109081011", "story_v_out_109081.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_18 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_18 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_18

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_18 and arg_48_1.time_ < var_51_10 + var_51_18 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play109081012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 109081012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play109081013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.bgs_.S0905 == nil then
				local var_55_0 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0905")
				var_55_0.name = "S0905"
				var_55_0.transform.parent = arg_52_1.stage_.transform
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_.S0905 = var_55_0
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				local var_55_1 = arg_52_1.bgs_.S0905

				arg_52_1.bgs_.S0905.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_55_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_2 = var_55_1:GetComponent("SpriteRenderer")

				if var_55_2 and var_55_2.sprite then
					local var_55_3 = 2 * (var_55_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_55_1.transform.localScale = Vector3.New(var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "S0905" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_4 = arg_52_1.actors_["1050ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1050ui_story = var_55_4.localPosition
			end

			local var_55_5 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_5 then
				var_55_4.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_5)
				var_55_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_4.position).x, (manager.ui.mainCamera.transform.position - var_55_4.position).y, (manager.ui.mainCamera.transform.position - var_55_4.position).z)
				var_55_4.localEulerAngles.z = 0
				var_55_4.localEulerAngles.x = 0
				var_55_4.localEulerAngles = var_55_4.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_5 and arg_52_1.time_ < 0 + var_55_5 + arg_55_0 then
				var_55_4.localPosition = Vector3.New(0, 100, 0)
				var_55_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_4.position).x, (manager.ui.mainCamera.transform.position - var_55_4.position).y, (manager.ui.mainCamera.transform.position - var_55_4.position).z)
				var_55_4.localEulerAngles.z = 0
				var_55_4.localEulerAngles.x = 0
				var_55_4.localEulerAngles = var_55_4.localEulerAngles
			end

			local var_55_6 = arg_52_1.actors_["1099ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1099ui_story = var_55_6.localPosition
			end

			local var_55_7 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				var_55_6.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_7)
				var_55_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_6.position).x, (manager.ui.mainCamera.transform.position - var_55_6.position).y, (manager.ui.mainCamera.transform.position - var_55_6.position).z)
				var_55_6.localEulerAngles.z = 0
				var_55_6.localEulerAngles.x = 0
				var_55_6.localEulerAngles = var_55_6.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				var_55_6.localPosition = Vector3.New(0, 100, 0)
				var_55_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_6.position).x, (manager.ui.mainCamera.transform.position - var_55_6.position).y, (manager.ui.mainCamera.transform.position - var_55_6.position).z)
				var_55_6.localEulerAngles.z = 0
				var_55_6.localEulerAngles.x = 0
				var_55_6.localEulerAngles = var_55_6.localEulerAngles
			end

			local var_55_8 = manager.ui.mainCamera.transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.shakeOldPos = var_55_8.localPosition
			end

			local var_55_9 = 3

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_9 then
				local var_55_10, var_55_11 = math.modf((arg_52_1.time_ - 0) / 0.066)

				var_55_8.localPosition = Vector3.New(var_55_11 * 0.13, var_55_11 * 0.13, var_55_11 * 0.13) + arg_52_1.var_.shakeOldPos
			end

			if arg_52_1.time_ >= 0 + var_55_9 and arg_52_1.time_ < 0 + var_55_9 + arg_55_0 then
				var_55_8.localPosition = arg_52_1.var_.shakeOldPos
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				local var_55_12 = arg_52_1.bgs_.S0905:GetComponent("SpriteRenderer")

				if var_55_12 then
					arg_52_1.var_.alphaOldValueS0905 = var_55_12.color.a
					arg_52_1.var_.alphaMatValueS0905 = var_55_12
				end

				arg_52_1.var_.alphaOldValueS0905 = 0
			end

			local var_55_13 = 1.5

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_13 then
				if arg_52_1.var_.alphaMatValueS0905 then
					arg_52_1.var_.alphaMatValueS0905.color.a = Mathf.Lerp(arg_52_1.var_.alphaOldValueS0905, 1, (arg_52_1.time_ - 0) / var_55_13)
					arg_52_1.var_.alphaMatValueS0905.color = arg_52_1.var_.alphaMatValueS0905.color
				end
			end

			if arg_52_1.time_ >= 0 + var_55_13 and arg_52_1.time_ < 0 + var_55_13 + arg_55_0 and arg_52_1.var_.alphaMatValueS0905 then
				arg_52_1.var_.alphaMatValueS0905.color.a = 1
				arg_52_1.var_.alphaMatValueS0905.color = arg_52_1.var_.alphaMatValueS0905.color
			end

			local var_55_14 = arg_52_1.bgs_.S0905.transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0905 = var_55_14.localPosition
			end

			local var_55_15 = 3

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_15 then
				var_55_14.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0905, Vector3.New(0, 1, 9.5), (arg_52_1.time_ - 0) / var_55_15)
			end

			if arg_52_1.time_ >= 0 + var_55_15 and arg_52_1.time_ < 0 + var_55_15 + arg_55_0 then
				var_55_14.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:AudioAction("stop", "music", "se_story_9", "se_story_9_shock02_loop", "")

				local var_55_18 = manager.audio:GetAudioName("se_story_9", "se_story_9_shock02_loop")

				if "" ~= "" then
					if arg_52_1.bgmTxt_.text ~= var_55_18 and arg_52_1.bgmTxt_.text ~= "" then
						if arg_52_1.bgmTxt2_.text ~= "" then
							arg_52_1.bgmTxt_.text = arg_52_1.bgmTxt2_.text
						end

						arg_52_1.bgmTxt2_.text = var_55_18

						arg_52_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_52_1.bgmTxt_.text = var_55_18
						arg_52_1.bgmTxt2_.text = var_55_18
					end

					if arg_52_1.bgmTimer then
						arg_52_1.bgmTimer:Stop()

						arg_52_1.bgmTimer = nil
					end

					if arg_52_1.settingData.show_music_name == 1 then
						arg_52_1.musicController:SetSelectedState("show")
						arg_52_1.musicAnimator_:Play("open", 0, 0)

						if arg_52_1.settingData.music_time ~= 0 then
							arg_52_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_52_1.settingData.music_time), function()
								if arg_52_1 == nil or isNil(arg_52_1.bgmTxt_) then
									return
								end

								arg_52_1.musicController:SetSelectedState("hide")
								arg_52_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_52_1.time_ and arg_52_1.time_ <= 0.433333333333333 + arg_55_0 then
				arg_52_1:AudioAction("play", "effect", "se_story_9", "se_story_9_monster", "")
			end

			local var_55_20 = 0
			local var_55_21 = 0.1

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_22 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_22:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_52_1.dialogCg_.alpha = arg_57_0
				end))
				var_55_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[159].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_23 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(109081012).content)

				arg_52_1.text_.text = var_55_23

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_25 = 4 <= 0 and var_55_21 or var_55_21 * (utf8.len(var_55_23) / 4)

				if (4 <= 0 and var_55_21 or var_55_21 * (utf8.len(var_55_23) / 4)) > 0 and var_55_21 < var_55_25 then
					arg_52_1.talkMaxDuration = var_55_25
					var_55_20 = var_55_20 + 0.3

					if var_55_25 + var_55_20 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_25 + var_55_20
					end
				end

				arg_52_1.text_.text = var_55_23
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_26 = var_55_20 + 0.3
			local var_55_27 = math.max(var_55_21, arg_52_1.talkMaxDuration)

			if var_55_20 + 0.3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_26 + var_55_27 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_26) / var_55_27

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_26 + var_55_27 and arg_52_1.time_ < var_55_26 + var_55_27 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "S0905",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play109081013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 109081013
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play109081014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:AudioAction("play", "effect", "se_story_9", "se_story_9_monster02", "")
			end

			local var_62_1 = 0
			local var_62_2 = 1.15

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(109081013).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 46 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 46)

				if (46 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 46)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_6 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_6 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_6

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_6 and arg_59_1.time_ < var_62_1 + var_62_6 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play109081014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 109081014
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play109081015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.725

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(109081014).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 29 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 29)

				if (29 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 29)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play109081015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 109081015
		arg_67_1.duration_ = 10

		local var_67_0 = {
			ja = 10,
			ko = 8,
			zh = 5.9,
			en = 6.533
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play109081016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.5

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(109081015)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 20 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 20)

				if (20 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 20)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081015", "story_v_out_109081.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_109081", "109081015", "story_v_out_109081.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_109081", "109081015", "story_v_out_109081.awb")

						arg_67_1:RecordAudio("109081015", var_70_6)
						arg_67_1:RecordAudio("109081015", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_109081", "109081015", "story_v_out_109081.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_109081", "109081015", "story_v_out_109081.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play109081016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 109081016
		arg_71_1.duration_ = 9.8

		local var_71_0 = {
			ja = 9.8,
			ko = 6.2,
			zh = 5.033,
			en = 6.433
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play109081017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(109081016)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 16 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 16)

				if (16 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 16)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081016", "story_v_out_109081.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_109081", "109081016", "story_v_out_109081.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_109081", "109081016", "story_v_out_109081.awb")

						arg_71_1:RecordAudio("109081016", var_74_6)
						arg_71_1:RecordAudio("109081016", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_109081", "109081016", "story_v_out_109081.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_109081", "109081016", "story_v_out_109081.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play109081017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 109081017
		arg_75_1.duration_ = 14.7

		local var_75_0 = {
			ja = 14.7,
			ko = 6.733,
			zh = 8,
			en = 7.433
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play109081018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.7

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(109081017)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 28 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 28)

				if (28 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 28)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081017", "story_v_out_109081.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_109081", "109081017", "story_v_out_109081.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_109081", "109081017", "story_v_out_109081.awb")

						arg_75_1:RecordAudio("109081017", var_78_6)
						arg_75_1:RecordAudio("109081017", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_109081", "109081017", "story_v_out_109081.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_109081", "109081017", "story_v_out_109081.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play109081018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 109081018
		arg_79_1.duration_ = 1.43

		local var_79_0 = {
			ja = 1.433,
			ko = 1.233,
			zh = 1.233,
			en = 1.266
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play109081019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.1

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:GetWordFromCfg(109081018)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 4 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 4)

				if (4 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 4)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081018", "story_v_out_109081.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_109081", "109081018", "story_v_out_109081.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_109081", "109081018", "story_v_out_109081.awb")

						arg_79_1:RecordAudio("109081018", var_82_6)
						arg_79_1:RecordAudio("109081018", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_109081", "109081018", "story_v_out_109081.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_109081", "109081018", "story_v_out_109081.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play109081019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 109081019
		arg_83_1.duration_ = 3.57

		local var_83_0 = {
			ja = 2.5,
			ko = 2.666,
			zh = 3.566,
			en = 3.5
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play109081020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.325

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:GetWordFromCfg(109081019)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 13 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 13)

				if (13 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 13)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081019", "story_v_out_109081.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_109081", "109081019", "story_v_out_109081.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_109081", "109081019", "story_v_out_109081.awb")

						arg_83_1:RecordAudio("109081019", var_86_6)
						arg_83_1:RecordAudio("109081019", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_109081", "109081019", "story_v_out_109081.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_109081", "109081019", "story_v_out_109081.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play109081020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 109081020
		arg_87_1.duration_ = 14.07

		local var_87_0 = {
			ja = 9.566,
			ko = 11.866,
			zh = 12.8,
			en = 14.066
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play109081021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.975

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(109081020)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 45 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 45)

				if (45 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 45)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081020", "story_v_out_109081.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_109081", "109081020", "story_v_out_109081.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_109081", "109081020", "story_v_out_109081.awb")

						arg_87_1:RecordAudio("109081020", var_90_6)
						arg_87_1:RecordAudio("109081020", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_109081", "109081020", "story_v_out_109081.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_109081", "109081020", "story_v_out_109081.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play109081021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 109081021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play109081022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_94_0 = 1.5

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				local var_94_1, var_94_2 = math.modf((arg_91_1.time_ - 0) / 0.099)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_94_2 * 0.13, var_94_2 * 0.13, var_94_2 * 0.13) + arg_91_1.var_.shakeOldPos
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				manager.ui.mainCamera.transform.localPosition = arg_91_1.var_.shakeOldPos
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:AudioAction("play", "effect", "se_story_9", "se_story_9_monster03", "")
			end

			local var_94_4 = 0
			local var_94_5 = 0.1

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[159].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(109081021).content)

				arg_91_1.text_.text = var_94_6

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_8 = 4 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_6) / 4)

				if (4 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_6) / 4)) > 0 and var_94_5 < var_94_8 then
					arg_91_1.talkMaxDuration = var_94_8

					if var_94_8 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_6
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_9 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_9 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_9

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_9 and arg_91_1.time_ < var_94_4 + var_94_9 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play109081022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 109081022
		arg_95_1.duration_ = 5.77

		local var_95_0 = {
			ja = 5.765999999999,
			ko = 4.399999999999,
			zh = 4.232999999999,
			en = 4.599999999999
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play109081023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				local var_98_0 = arg_95_1.bgs_.C07_1

				arg_95_1.bgs_.C07_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_98_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_1 = var_98_0:GetComponent("SpriteRenderer")

				if var_98_1 and var_98_1.sprite then
					local var_98_2 = 2 * (var_98_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_98_0.transform.localScale = Vector3.New(var_98_2 / var_98_1.sprite.bounds.size.y < var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x and var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x or var_98_2 / var_98_1.sprite.bounds.size.y, var_98_2 / var_98_1.sprite.bounds.size.y < var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x and var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x or var_98_2 / var_98_1.sprite.bounds.size.y, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "C07_1" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				local var_98_3 = arg_95_1.bgs_.C07_1:GetComponent("SpriteRenderer")

				if var_98_3 then
					arg_95_1.var_.alphaOldValueC07_1 = var_98_3.color.a
					arg_95_1.var_.alphaMatValueC07_1 = var_98_3
				end

				arg_95_1.var_.alphaOldValueC07_1 = 0
			end

			local var_98_4 = 1.5

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				if arg_95_1.var_.alphaMatValueC07_1 then
					arg_95_1.var_.alphaMatValueC07_1.color.a = Mathf.Lerp(arg_95_1.var_.alphaOldValueC07_1, 1, (arg_95_1.time_ - 0) / var_98_4)
					arg_95_1.var_.alphaMatValueC07_1.color = arg_95_1.var_.alphaMatValueC07_1.color
				end
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 and arg_95_1.var_.alphaMatValueC07_1 then
				arg_95_1.var_.alphaMatValueC07_1.color.a = 1
				arg_95_1.var_.alphaMatValueC07_1.color = arg_95_1.var_.alphaMatValueC07_1.color
			end

			local var_98_5 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			if arg_95_1.time_ >= var_98_5 + 1.5 and arg_95_1.time_ < var_98_5 + 1.5 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			local var_98_6 = arg_95_1.actors_["10004ui_story"].transform

			if 1 < arg_95_1.time_ and arg_95_1.time_ <= 1 + arg_98_0 then
				arg_95_1.var_.moveOldPos10004ui_story = var_98_6.localPosition
			end

			local var_98_7 = 0.001

			if 1 <= arg_95_1.time_ and arg_95_1.time_ < 1 + var_98_7 then
				var_98_6.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10004ui_story, Vector3.New(0, -1.1, -5.6), (arg_95_1.time_ - 1) / var_98_7)
				var_98_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_6.position).x, (manager.ui.mainCamera.transform.position - var_98_6.position).y, (manager.ui.mainCamera.transform.position - var_98_6.position).z)
				var_98_6.localEulerAngles.z = 0
				var_98_6.localEulerAngles.x = 0
				var_98_6.localEulerAngles = var_98_6.localEulerAngles
			end

			if arg_95_1.time_ >= 1 + var_98_7 and arg_95_1.time_ < 1 + var_98_7 + arg_98_0 then
				var_98_6.localPosition = Vector3.New(0, -1.1, -5.6)
				var_98_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_6.position).x, (manager.ui.mainCamera.transform.position - var_98_6.position).y, (manager.ui.mainCamera.transform.position - var_98_6.position).z)
				var_98_6.localEulerAngles.z = 0
				var_98_6.localEulerAngles.x = 0
				var_98_6.localEulerAngles = var_98_6.localEulerAngles
			end

			if 1 < arg_95_1.time_ and arg_95_1.time_ <= 1 + arg_98_0 then
				arg_95_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action7_2")
			end

			local var_98_8 = arg_95_1.actors_["10004ui_story"]

			if 1 < arg_95_1.time_ and arg_95_1.time_ <= 1 + arg_98_0 and not isNil(var_98_8) and arg_95_1.var_.characterEffect10004ui_story == nil then
				arg_95_1.var_.characterEffect10004ui_story = var_98_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_9 = 0.2

			if 1 <= arg_95_1.time_ and arg_95_1.time_ < 1 + var_98_9 and not isNil(var_98_8) then
				if arg_95_1.var_.characterEffect10004ui_story and not isNil(var_98_8) then
					arg_95_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 1 + var_98_9 and arg_95_1.time_ < 1 + var_98_9 + arg_98_0 and not isNil(var_98_8) and arg_95_1.var_.characterEffect10004ui_story then
				arg_95_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			if 1 < arg_95_1.time_ and arg_95_1.time_ <= 1 + arg_98_0 then
				arg_95_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_98_11 = 1.499999999999
			local var_98_12 = 0.3

			if 1.499999999999 < arg_95_1.time_ and arg_95_1.time_ <= var_98_11 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_13 = arg_95_1:GetWordFromCfg(109081022)
				local var_98_14 = arg_95_1:FormatText(var_98_13.content)

				arg_95_1.text_.text = var_98_14

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_16 = 12 <= 0 and var_98_12 or var_98_12 * (utf8.len(var_98_14) / 12)

				if (12 <= 0 and var_98_12 or var_98_12 * (utf8.len(var_98_14) / 12)) > 0 and var_98_12 < var_98_16 then
					arg_95_1.talkMaxDuration = var_98_16

					if var_98_16 + var_98_11 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_16 + var_98_11
					end
				end

				arg_95_1.text_.text = var_98_14
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081022", "story_v_out_109081.awb") ~= 0 then
					local var_98_17 = manager.audio:GetVoiceLength("story_v_out_109081", "109081022", "story_v_out_109081.awb") / 1000

					if var_98_17 + var_98_11 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_17 + var_98_11
					end

					if var_98_13.prefab_name ~= "" and arg_95_1.actors_[var_98_13.prefab_name] ~= nil then
						local var_98_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_13.prefab_name].transform, "story_v_out_109081", "109081022", "story_v_out_109081.awb")

						arg_95_1:RecordAudio("109081022", var_98_18)
						arg_95_1:RecordAudio("109081022", var_98_18)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_109081", "109081022", "story_v_out_109081.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_109081", "109081022", "story_v_out_109081.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_19 = math.max(var_98_12, arg_95_1.talkMaxDuration)

			if var_98_11 <= arg_95_1.time_ and arg_95_1.time_ < var_98_11 + var_98_19 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_11) / var_98_19

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_11 + var_98_19 and arg_95_1.time_ < var_98_11 + var_98_19 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play109081023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 109081023
		arg_99_1.duration_ = 8.67

		local var_99_0 = {
			ja = 8.666,
			ko = 5.866,
			zh = 4.3,
			en = 5.466
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play109081024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if arg_99_1.actors_["4014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4014_tpose"))) then
				local var_102_0 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_99_1.stage_.transform)

				var_102_0.name = "4014_tpose"
				var_102_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["4014_tpose"] = var_102_0

				local var_102_1 = var_102_0:GetComponentInChildren(typeof(CharacterEffect))

				var_102_1.enabled = true

				local var_102_2 = GameObjectTools.GetOrAddComponent(var_102_0, typeof(DynamicBoneHelper))

				if var_102_2 then
					var_102_2:EnableDynamicBone(false)
				end

				arg_99_1:ShowWeapon(var_102_1.transform, false)

				arg_99_1.var_["4014_tpose" .. "Animator"] = var_102_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_99_1.var_["4014_tpose" .. "Animator"].applyRootMotion = true
				arg_99_1.var_["4014_tpose" .. "LipSync"] = var_102_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_102_3 = arg_99_1.actors_["4014_tpose"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos4014_tpose = var_102_3.localPosition

				local var_102_4 = GameObjectTools.GetOrAddComponent(var_102_3.gameObject, typeof(DynamicBoneHelper))

				if var_102_4 then
					var_102_4:EnableDynamicBone(false)
				end
			end

			local var_102_5 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_5 then
				var_102_3.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_99_1.time_ - 0) / var_102_5)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_5 and arg_99_1.time_ < 0 + var_102_5 + arg_102_0 then
				var_102_3.localPosition = Vector3.New(0, -1.95, -4.2)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles

				local var_102_6 = GameObjectTools.GetOrAddComponent(var_102_3.gameObject, typeof(DynamicBoneHelper))

				if var_102_6 then
					var_102_6:EnableDynamicBone(true)
				end
			end

			local var_102_7 = arg_99_1.actors_["4014_tpose"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_7) and arg_99_1.var_.characterEffect4014_tpose == nil then
				arg_99_1.var_.characterEffect4014_tpose = var_102_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_8 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_8 and not isNil(var_102_7) then
				if arg_99_1.var_.characterEffect4014_tpose and not isNil(var_102_7) then
					arg_99_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_8 and arg_99_1.time_ < 0 + var_102_8 + arg_102_0 and not isNil(var_102_7) and arg_99_1.var_.characterEffect4014_tpose then
				arg_99_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_102_10 = arg_99_1.actors_["10004ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10004ui_story = var_102_10.localPosition
			end

			local var_102_11 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_11 then
				var_102_10.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10004ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_11)
				var_102_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_10.position).x, (manager.ui.mainCamera.transform.position - var_102_10.position).y, (manager.ui.mainCamera.transform.position - var_102_10.position).z)
				var_102_10.localEulerAngles.z = 0
				var_102_10.localEulerAngles.x = 0
				var_102_10.localEulerAngles = var_102_10.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_11 and arg_99_1.time_ < 0 + var_102_11 + arg_102_0 then
				var_102_10.localPosition = Vector3.New(0, 100, 0)
				var_102_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_10.position).x, (manager.ui.mainCamera.transform.position - var_102_10.position).y, (manager.ui.mainCamera.transform.position - var_102_10.position).z)
				var_102_10.localEulerAngles.z = 0
				var_102_10.localEulerAngles.x = 0
				var_102_10.localEulerAngles = var_102_10.localEulerAngles
			end

			local var_102_12 = 0
			local var_102_13 = 0.45

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_12 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_14 = arg_99_1:GetWordFromCfg(109081023)
				local var_102_15 = arg_99_1:FormatText(var_102_14.content)

				arg_99_1.text_.text = var_102_15

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_17 = 18 <= 0 and var_102_13 or var_102_13 * (utf8.len(var_102_15) / 18)

				if (18 <= 0 and var_102_13 or var_102_13 * (utf8.len(var_102_15) / 18)) > 0 and var_102_13 < var_102_17 then
					arg_99_1.talkMaxDuration = var_102_17

					if var_102_17 + var_102_12 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_17 + var_102_12
					end
				end

				arg_99_1.text_.text = var_102_15
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081023", "story_v_out_109081.awb") ~= 0 then
					local var_102_18 = manager.audio:GetVoiceLength("story_v_out_109081", "109081023", "story_v_out_109081.awb") / 1000

					if var_102_18 + var_102_12 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_18 + var_102_12
					end

					if var_102_14.prefab_name ~= "" and arg_99_1.actors_[var_102_14.prefab_name] ~= nil then
						local var_102_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_14.prefab_name].transform, "story_v_out_109081", "109081023", "story_v_out_109081.awb")

						arg_99_1:RecordAudio("109081023", var_102_19)
						arg_99_1:RecordAudio("109081023", var_102_19)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_109081", "109081023", "story_v_out_109081.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_109081", "109081023", "story_v_out_109081.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_20 = math.max(var_102_13, arg_99_1.talkMaxDuration)

			if var_102_12 <= arg_99_1.time_ and arg_99_1.time_ < var_102_12 + var_102_20 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_12) / var_102_20

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_12 + var_102_20 and arg_99_1.time_ < var_102_12 + var_102_20 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play109081024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 109081024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play109081025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos4014_tpose = arg_103_1.actors_["4014_tpose"].transform.localPosition

				local var_106_0 = GameObjectTools.GetOrAddComponent(arg_103_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_106_0 then
					var_106_0:EnableDynamicBone(false)
				end
			end

			local var_106_1 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 then
				arg_103_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_103_1.time_ - 0) / var_106_1)
				arg_103_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["4014_tpose"].transform.position).z)
				arg_103_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["4014_tpose"].transform.localEulerAngles = arg_103_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 then
				arg_103_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["4014_tpose"].transform.position).z)
				arg_103_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["4014_tpose"].transform.localEulerAngles = arg_103_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_106_2 = GameObjectTools.GetOrAddComponent(arg_103_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_106_2 then
					var_106_2:EnableDynamicBone(true)
				end
			end

			local var_106_3 = 0
			local var_106_4 = 0.425

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_5 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(109081024).content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 17 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_5) / 17)

				if (17 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_5) / 17)) > 0 and var_106_4 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_3
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_4, arg_103_1.talkMaxDuration)

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_3) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_3 + var_106_8 and arg_103_1.time_ < var_106_3 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play109081025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 109081025
		arg_107_1.duration_ = 2.17

		local var_107_0 = {
			ja = 1.999999999999,
			ko = 2.166,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play109081026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if arg_107_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_110_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_107_1.stage_.transform)

				var_110_0.name = "1038ui_story"
				var_110_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_107_1.actors_["1038ui_story"] = var_110_0

				local var_110_1 = var_110_0:GetComponentInChildren(typeof(CharacterEffect))

				var_110_1.enabled = true

				local var_110_2 = GameObjectTools.GetOrAddComponent(var_110_0, typeof(DynamicBoneHelper))

				if var_110_2 then
					var_110_2:EnableDynamicBone(false)
				end

				arg_107_1:ShowWeapon(var_110_1.transform, false)

				arg_107_1.var_["1038ui_story" .. "Animator"] = var_110_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_107_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_107_1.var_["1038ui_story" .. "LipSync"] = var_110_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_110_3 = arg_107_1.actors_["1038ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1038ui_story = var_110_3.localPosition
			end

			local var_110_4 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				var_110_3.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1038ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_107_1.time_ - 0) / var_110_4)
				var_110_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_3.position).x, (manager.ui.mainCamera.transform.position - var_110_3.position).y, (manager.ui.mainCamera.transform.position - var_110_3.position).z)
				var_110_3.localEulerAngles.z = 0
				var_110_3.localEulerAngles.x = 0
				var_110_3.localEulerAngles = var_110_3.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				var_110_3.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_110_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_3.position).x, (manager.ui.mainCamera.transform.position - var_110_3.position).y, (manager.ui.mainCamera.transform.position - var_110_3.position).z)
				var_110_3.localEulerAngles.z = 0
				var_110_3.localEulerAngles.x = 0
				var_110_3.localEulerAngles = var_110_3.localEulerAngles
			end

			local var_110_5 = arg_107_1.actors_["1038ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.characterEffect1038ui_story == nil then
				arg_107_1.var_.characterEffect1038ui_story = var_110_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_6 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_6 and not isNil(var_110_5) then
				if arg_107_1.var_.characterEffect1038ui_story and not isNil(var_110_5) then
					arg_107_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_6 and arg_107_1.time_ < 0 + var_110_6 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.characterEffect1038ui_story then
				arg_107_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_110_8 = 0
			local var_110_9 = 0.25

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(109081025)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_13 = 10 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 10)

				if (10 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 10)) > 0 and var_110_9 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081025", "story_v_out_109081.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_109081", "109081025", "story_v_out_109081.awb") / 1000

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_109081", "109081025", "story_v_out_109081.awb")

						arg_107_1:RecordAudio("109081025", var_110_15)
						arg_107_1:RecordAudio("109081025", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_109081", "109081025", "story_v_out_109081.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_109081", "109081025", "story_v_out_109081.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = math.max(var_110_9, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_16 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_8) / var_110_16

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_16 and arg_107_1.time_ < var_110_8 + var_110_16 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play109081026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 109081026
		arg_111_1.duration_ = 2.1

		local var_111_0 = {
			ja = 1.999999999999,
			ko = 2.1,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play109081027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if arg_111_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_114_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_111_1.stage_.transform)

				var_114_0.name = "1084ui_story"
				var_114_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["1084ui_story"] = var_114_0

				local var_114_1 = var_114_0:GetComponentInChildren(typeof(CharacterEffect))

				var_114_1.enabled = true

				local var_114_2 = GameObjectTools.GetOrAddComponent(var_114_0, typeof(DynamicBoneHelper))

				if var_114_2 then
					var_114_2:EnableDynamicBone(false)
				end

				arg_111_1:ShowWeapon(var_114_1.transform, false)

				arg_111_1.var_["1084ui_story" .. "Animator"] = var_114_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_111_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_111_1.var_["1084ui_story" .. "LipSync"] = var_114_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_114_3 = arg_111_1.actors_["1084ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1084ui_story = var_114_3.localPosition

				arg_111_1:ShowWeapon(arg_111_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_3.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_111_1.time_ - 0) / var_114_4)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			local var_114_5 = arg_111_1.actors_["1084ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.characterEffect1084ui_story == nil then
				arg_111_1.var_.characterEffect1084ui_story = var_114_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_6 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.characterEffect1084ui_story and not isNil(var_114_5) then
					arg_111_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.characterEffect1084ui_story then
				arg_111_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_114_8 = arg_111_1.actors_["1038ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.characterEffect1038ui_story == nil then
				arg_111_1.var_.characterEffect1038ui_story = var_114_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_9 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_9 and not isNil(var_114_8) then
				if arg_111_1.var_.characterEffect1038ui_story and not isNil(var_114_8) then
					arg_111_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_9)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_9 and arg_111_1.time_ < 0 + var_114_9 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.characterEffect1038ui_story then
				arg_111_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_114_10 = 0
			local var_114_11 = 0.2

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_12 = arg_111_1:GetWordFromCfg(109081026)
				local var_114_13 = arg_111_1:FormatText(var_114_12.content)

				arg_111_1.text_.text = var_114_13

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_15 = 8 <= 0 and var_114_11 or var_114_11 * (utf8.len(var_114_13) / 8)

				if (8 <= 0 and var_114_11 or var_114_11 * (utf8.len(var_114_13) / 8)) > 0 and var_114_11 < var_114_15 then
					arg_111_1.talkMaxDuration = var_114_15

					if var_114_15 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_15 + var_114_10
					end
				end

				arg_111_1.text_.text = var_114_13
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081026", "story_v_out_109081.awb") ~= 0 then
					local var_114_16 = manager.audio:GetVoiceLength("story_v_out_109081", "109081026", "story_v_out_109081.awb") / 1000

					if var_114_16 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_16 + var_114_10
					end

					if var_114_12.prefab_name ~= "" and arg_111_1.actors_[var_114_12.prefab_name] ~= nil then
						local var_114_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_12.prefab_name].transform, "story_v_out_109081", "109081026", "story_v_out_109081.awb")

						arg_111_1:RecordAudio("109081026", var_114_17)
						arg_111_1:RecordAudio("109081026", var_114_17)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_109081", "109081026", "story_v_out_109081.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_109081", "109081026", "story_v_out_109081.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_18 = math.max(var_114_11, arg_111_1.talkMaxDuration)

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_18 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_10) / var_114_18

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_10 + var_114_18 and arg_111_1.time_ < var_114_10 + var_114_18 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play109081027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 109081027
		arg_115_1.duration_ = 8.1

		local var_115_0 = {
			ja = 7.8,
			ko = 7.933,
			zh = 7.966,
			en = 8.1
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play109081028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_118_0 = arg_115_1.actors_["4014_tpose"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect4014_tpose == nil then
				arg_115_1.var_.characterEffect4014_tpose = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_1 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 and not isNil(var_118_0) then
				if arg_115_1.var_.characterEffect4014_tpose and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect4014_tpose then
				arg_115_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_118_3 = arg_115_1.actors_["1038ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1038ui_story = var_118_3.localPosition
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_3.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_4)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_3.localPosition = Vector3.New(0, 100, 0)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			local var_118_5 = arg_115_1.actors_["1084ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1084ui_story = var_118_5.localPosition
			end

			local var_118_6 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 then
				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_6)
				var_118_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_5.position).x, (manager.ui.mainCamera.transform.position - var_118_5.position).y, (manager.ui.mainCamera.transform.position - var_118_5.position).z)
				var_118_5.localEulerAngles.z = 0
				var_118_5.localEulerAngles.x = 0
				var_118_5.localEulerAngles = var_118_5.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(0, 100, 0)
				var_118_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_5.position).x, (manager.ui.mainCamera.transform.position - var_118_5.position).y, (manager.ui.mainCamera.transform.position - var_118_5.position).z)
				var_118_5.localEulerAngles.z = 0
				var_118_5.localEulerAngles.x = 0
				var_118_5.localEulerAngles = var_118_5.localEulerAngles
			end

			local var_118_7 = arg_115_1.actors_["4014_tpose"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos4014_tpose = var_118_7.localPosition

				local var_118_8 = GameObjectTools.GetOrAddComponent(var_118_7.gameObject, typeof(DynamicBoneHelper))

				if var_118_8 then
					var_118_8:EnableDynamicBone(false)
				end
			end

			local var_118_9 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_9 then
				var_118_7.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_115_1.time_ - 0) / var_118_9)
				var_118_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_7.position).x, (manager.ui.mainCamera.transform.position - var_118_7.position).y, (manager.ui.mainCamera.transform.position - var_118_7.position).z)
				var_118_7.localEulerAngles.z = 0
				var_118_7.localEulerAngles.x = 0
				var_118_7.localEulerAngles = var_118_7.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_9 and arg_115_1.time_ < 0 + var_118_9 + arg_118_0 then
				var_118_7.localPosition = Vector3.New(0, -1.95, -4.2)
				var_118_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_7.position).x, (manager.ui.mainCamera.transform.position - var_118_7.position).y, (manager.ui.mainCamera.transform.position - var_118_7.position).z)
				var_118_7.localEulerAngles.z = 0
				var_118_7.localEulerAngles.x = 0
				var_118_7.localEulerAngles = var_118_7.localEulerAngles

				local var_118_10 = GameObjectTools.GetOrAddComponent(var_118_7.gameObject, typeof(DynamicBoneHelper))

				if var_118_10 then
					var_118_10:EnableDynamicBone(true)
				end
			end

			local var_118_11 = 0
			local var_118_12 = 0.7

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_13 = arg_115_1:GetWordFromCfg(109081027)
				local var_118_14 = arg_115_1:FormatText(var_118_13.content)

				arg_115_1.text_.text = var_118_14

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_16 = 28 <= 0 and var_118_12 or var_118_12 * (utf8.len(var_118_14) / 28)

				if (28 <= 0 and var_118_12 or var_118_12 * (utf8.len(var_118_14) / 28)) > 0 and var_118_12 < var_118_16 then
					arg_115_1.talkMaxDuration = var_118_16

					if var_118_16 + var_118_11 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_16 + var_118_11
					end
				end

				arg_115_1.text_.text = var_118_14
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081027", "story_v_out_109081.awb") ~= 0 then
					local var_118_17 = manager.audio:GetVoiceLength("story_v_out_109081", "109081027", "story_v_out_109081.awb") / 1000

					if var_118_17 + var_118_11 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_17 + var_118_11
					end

					if var_118_13.prefab_name ~= "" and arg_115_1.actors_[var_118_13.prefab_name] ~= nil then
						local var_118_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_13.prefab_name].transform, "story_v_out_109081", "109081027", "story_v_out_109081.awb")

						arg_115_1:RecordAudio("109081027", var_118_18)
						arg_115_1:RecordAudio("109081027", var_118_18)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_109081", "109081027", "story_v_out_109081.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_109081", "109081027", "story_v_out_109081.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_19 = math.max(var_118_12, arg_115_1.talkMaxDuration)

			if var_118_11 <= arg_115_1.time_ and arg_115_1.time_ < var_118_11 + var_118_19 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_11) / var_118_19

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_11 + var_118_19 and arg_115_1.time_ < var_118_11 + var_118_19 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play109081028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 109081028
		arg_119_1.duration_ = 8.13

		local var_119_0 = {
			ja = 3.333,
			ko = 5.7,
			zh = 7.233,
			en = 8.133
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play109081029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos4014_tpose = arg_119_1.actors_["4014_tpose"].transform.localPosition

				local var_122_0 = GameObjectTools.GetOrAddComponent(arg_119_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_122_0 then
					var_122_0:EnableDynamicBone(false)
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_1)
				arg_119_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["4014_tpose"].transform.position).z)
				arg_119_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["4014_tpose"].transform.localEulerAngles = arg_119_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["4014_tpose"].transform.position).z)
				arg_119_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["4014_tpose"].transform.localEulerAngles = arg_119_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_122_2 = GameObjectTools.GetOrAddComponent(arg_119_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_122_2 then
					var_122_2:EnableDynamicBone(true)
				end
			end

			local var_122_3 = arg_119_1.actors_["1099ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1099ui_story = var_122_3.localPosition
			end

			local var_122_4 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				var_122_3.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1099ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_119_1.time_ - 0) / var_122_4)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				var_122_3.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			local var_122_5 = arg_119_1.actors_["1099ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1099ui_story == nil then
				arg_119_1.var_.characterEffect1099ui_story = var_122_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_6 and not isNil(var_122_5) then
				if arg_119_1.var_.characterEffect1099ui_story and not isNil(var_122_5) then
					arg_119_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_6 and arg_119_1.time_ < 0 + var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1099ui_story then
				arg_119_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_122_8 = 0
			local var_122_9 = 0.95

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(109081028)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 38 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 38)

				if (38 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 38)) > 0 and var_122_9 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081028", "story_v_out_109081.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_out_109081", "109081028", "story_v_out_109081.awb") / 1000

					if var_122_14 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_8
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_109081", "109081028", "story_v_out_109081.awb")

						arg_119_1:RecordAudio("109081028", var_122_15)
						arg_119_1:RecordAudio("109081028", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_109081", "109081028", "story_v_out_109081.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_109081", "109081028", "story_v_out_109081.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_16 = math.max(var_122_9, arg_119_1.talkMaxDuration)

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_16 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_8) / var_122_16

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_8 + var_122_16 and arg_119_1.time_ < var_122_8 + var_122_16 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play109081029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 109081029
		arg_123_1.duration_ = 3.53

		local var_123_0 = {
			ja = 3.533,
			ko = 3.4,
			zh = 3.333,
			en = 2.8
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play109081030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_126_0 = 0
			local var_126_1 = 0.45

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(109081029)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 18 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 18)

				if (18 <= 0 and var_126_1 or var_126_1 * (utf8.len(var_126_3) / 18)) > 0 and var_126_1 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081029", "story_v_out_109081.awb") ~= 0 then
					local var_126_6 = manager.audio:GetVoiceLength("story_v_out_109081", "109081029", "story_v_out_109081.awb") / 1000

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end

					if var_126_2.prefab_name ~= "" and arg_123_1.actors_[var_126_2.prefab_name] ~= nil then
						local var_126_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_2.prefab_name].transform, "story_v_out_109081", "109081029", "story_v_out_109081.awb")

						arg_123_1:RecordAudio("109081029", var_126_7)
						arg_123_1:RecordAudio("109081029", var_126_7)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_109081", "109081029", "story_v_out_109081.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_109081", "109081029", "story_v_out_109081.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_8 and arg_123_1.time_ < var_126_0 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play109081030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 109081030
		arg_127_1.duration_ = 2.23

		local var_127_0 = {
			ja = 1.999999999999,
			ko = 2.066,
			zh = 2.033,
			en = 2.233
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play109081031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1050ui_story = arg_127_1.actors_["1050ui_story"].transform.localPosition

				arg_127_1:ShowWeapon(arg_127_1.var_["1050ui_story" .. "Animator"].transform, true)
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1050ui_story, Vector3.New(0.7, -1, -6.1), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1050ui_story"].transform.position).z)
				arg_127_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1050ui_story"].transform.localEulerAngles = arg_127_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.1)
				arg_127_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1050ui_story"].transform.position).z)
				arg_127_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1050ui_story"].transform.localEulerAngles = arg_127_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1099ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1099ui_story == nil then
				arg_127_1.var_.characterEffect1099ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1099ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_2)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1099ui_story then
				arg_127_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_130_3 = arg_127_1.actors_["1050ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect1050ui_story == nil then
				arg_127_1.var_.characterEffect1050ui_story = var_130_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_4 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 and not isNil(var_130_3) then
				if arg_127_1.var_.characterEffect1050ui_story and not isNil(var_130_3) then
					arg_127_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect1050ui_story then
				arg_127_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			if 5.89805981832114e-17 < arg_127_1.time_ and arg_127_1.time_ <= 5.89805981832114e-17 + arg_130_0 then
				arg_127_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_130_6 = 0
			local var_130_7 = 0.25

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:GetWordFromCfg(109081030)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 10 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 10)

				if (10 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 10)) > 0 and var_130_7 < var_130_11 then
					arg_127_1.talkMaxDuration = var_130_11

					if var_130_11 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081030", "story_v_out_109081.awb") ~= 0 then
					local var_130_12 = manager.audio:GetVoiceLength("story_v_out_109081", "109081030", "story_v_out_109081.awb") / 1000

					if var_130_12 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_6
					end

					if var_130_8.prefab_name ~= "" and arg_127_1.actors_[var_130_8.prefab_name] ~= nil then
						local var_130_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_8.prefab_name].transform, "story_v_out_109081", "109081030", "story_v_out_109081.awb")

						arg_127_1:RecordAudio("109081030", var_130_13)
						arg_127_1:RecordAudio("109081030", var_130_13)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_109081", "109081030", "story_v_out_109081.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_109081", "109081030", "story_v_out_109081.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play109081031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 109081031
		arg_131_1.duration_ = 3.53

		local var_131_0 = {
			ja = 2.9,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 3.533
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play109081032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1099ui_story"]) and arg_131_1.var_.characterEffect1099ui_story == nil then
				arg_131_1.var_.characterEffect1099ui_story = arg_131_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1099ui_story"]) then
				if arg_131_1.var_.characterEffect1099ui_story and not isNil(arg_131_1.actors_["1099ui_story"]) then
					arg_131_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1099ui_story"]) and arg_131_1.var_.characterEffect1099ui_story then
				arg_131_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_134_2 = arg_131_1.actors_["1050ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect1050ui_story == nil then
				arg_131_1.var_.characterEffect1050ui_story = var_134_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_3 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.characterEffect1050ui_story and not isNil(var_134_2) then
					arg_131_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_3)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect1050ui_story then
				arg_131_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_134_4 = 0
			local var_134_5 = 0.25

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(109081031)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 10 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 10)

				if (10 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 10)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081031", "story_v_out_109081.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_109081", "109081031", "story_v_out_109081.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_109081", "109081031", "story_v_out_109081.awb")

						arg_131_1:RecordAudio("109081031", var_134_11)
						arg_131_1:RecordAudio("109081031", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_109081", "109081031", "story_v_out_109081.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_109081", "109081031", "story_v_out_109081.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play109081032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 109081032
		arg_135_1.duration_ = 8.73

		local var_135_0 = {
			ja = 8.733,
			ko = 5.733,
			zh = 4.833,
			en = 5.1
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
			arg_135_1.auto_ = false
		end

		function arg_135_1.playNext_(arg_137_0)
			arg_135_1.onStoryFinished_()
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1050ui_story = arg_135_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1050ui_story"].transform.position).z)
				arg_135_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1050ui_story"].transform.localEulerAngles = arg_135_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1050ui_story"].transform.position).z)
				arg_135_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1050ui_story"].transform.localEulerAngles = arg_135_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["1099ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1099ui_story = var_138_1.localPosition
			end

			local var_138_2 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 then
				var_138_1.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_2)
				var_138_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_1.position).x, (manager.ui.mainCamera.transform.position - var_138_1.position).y, (manager.ui.mainCamera.transform.position - var_138_1.position).z)
				var_138_1.localEulerAngles.z = 0
				var_138_1.localEulerAngles.x = 0
				var_138_1.localEulerAngles = var_138_1.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 then
				var_138_1.localPosition = Vector3.New(0, 100, 0)
				var_138_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_1.position).x, (manager.ui.mainCamera.transform.position - var_138_1.position).y, (manager.ui.mainCamera.transform.position - var_138_1.position).z)
				var_138_1.localEulerAngles.z = 0
				var_138_1.localEulerAngles.x = 0
				var_138_1.localEulerAngles = var_138_1.localEulerAngles
			end

			local var_138_3 = arg_135_1.actors_["4014_tpose"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos4014_tpose = var_138_3.localPosition

				local var_138_4 = GameObjectTools.GetOrAddComponent(var_138_3.gameObject, typeof(DynamicBoneHelper))

				if var_138_4 then
					var_138_4:EnableDynamicBone(false)
				end
			end

			local var_138_5 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_5 then
				var_138_3.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_135_1.time_ - 0) / var_138_5)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_5 and arg_135_1.time_ < 0 + var_138_5 + arg_138_0 then
				var_138_3.localPosition = Vector3.New(0, -1.95, -4.2)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles

				local var_138_6 = GameObjectTools.GetOrAddComponent(var_138_3.gameObject, typeof(DynamicBoneHelper))

				if var_138_6 then
					var_138_6:EnableDynamicBone(true)
				end
			end

			local var_138_7 = arg_135_1.actors_["4014_tpose"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.characterEffect4014_tpose == nil then
				arg_135_1.var_.characterEffect4014_tpose = var_138_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_8 and not isNil(var_138_7) then
				if arg_135_1.var_.characterEffect4014_tpose and not isNil(var_138_7) then
					arg_135_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_8 and arg_135_1.time_ < 0 + var_138_8 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.characterEffect4014_tpose then
				arg_135_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_138_10 = 0
			local var_138_11 = 0.4

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_12 = arg_135_1:GetWordFromCfg(109081032)
				local var_138_13 = arg_135_1:FormatText(var_138_12.content)

				arg_135_1.text_.text = var_138_13

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_15 = 16 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 16)

				if (16 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 16)) > 0 and var_138_11 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15

					if var_138_15 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_10
					end
				end

				arg_135_1.text_.text = var_138_13
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081032", "story_v_out_109081.awb") ~= 0 then
					local var_138_16 = manager.audio:GetVoiceLength("story_v_out_109081", "109081032", "story_v_out_109081.awb") / 1000

					if var_138_16 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_10
					end

					if var_138_12.prefab_name ~= "" and arg_135_1.actors_[var_138_12.prefab_name] ~= nil then
						local var_138_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_12.prefab_name].transform, "story_v_out_109081", "109081032", "story_v_out_109081.awb")

						arg_135_1:RecordAudio("109081032", var_138_17)
						arg_135_1:RecordAudio("109081032", var_138_17)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_109081", "109081032", "story_v_out_109081.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_109081", "109081032", "story_v_out_109081.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_18 = math.max(var_138_11, arg_135_1.talkMaxDuration)

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_18 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_10) / var_138_18

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_10 + var_138_18 and arg_135_1.time_ < var_138_10 + var_138_18 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C07_1",
		"TextureConfig/Background/S0905"
	},
	voices = {
		"story_v_out_109081.awb"
	}
}

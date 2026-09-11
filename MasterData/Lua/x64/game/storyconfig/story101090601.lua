return {
	Play109061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109061001
		arg_1_1.duration_ = 11.1

		local var_1_0 = {
			ja = 10.7,
			ko = 11.066,
			zh = 11.1,
			en = 9.9
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
				arg_1_0:Play109061002(arg_1_1)
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_8 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_8 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_8

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_8
						arg_1_1.bgmTxt2_.text = var_4_8
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

			local var_4_9 = 1.5

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_9 + 2 and arg_1_1.time_ < var_4_9 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_10 = "10004ui_story"

			if arg_1_1.actors_["10004ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10004ui_story"))) then
				local var_4_11 = Object.Instantiate(Asset.Load("Char/" .. "10004ui_story"), arg_1_1.stage_.transform)

				var_4_11.name = var_4_10
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_10] = var_4_11

				local var_4_12 = var_4_11:GetComponentInChildren(typeof(CharacterEffect))

				var_4_12.enabled = true

				local var_4_13 = GameObjectTools.GetOrAddComponent(var_4_11, typeof(DynamicBoneHelper))

				if var_4_13 then
					var_4_13:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_12.transform, false)

				arg_1_1.var_[var_4_10 .. "Animator"] = var_4_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_10 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_10 .. "LipSync"] = var_4_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_14 = arg_1_1.actors_["10004ui_story"]

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10004ui_story == nil then
				arg_1_1.var_.characterEffect10004ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.1

			if 1.5 <= arg_1_1.time_ and arg_1_1.time_ < 1.5 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect10004ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.5 + var_4_15 and arg_1_1.time_ < 1.5 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10004ui_story then
				arg_1_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_4_17 = arg_1_1.actors_["10004ui_story"].transform

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1.var_.moveOldPos10004ui_story = var_4_17.localPosition
			end

			local var_4_18 = 0.001

			if 1.5 <= arg_1_1.time_ and arg_1_1.time_ < 1.5 + var_4_18 then
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10004ui_story, Vector3.New(-0.7, -1.1, -5.6), (arg_1_1.time_ - 1.5) / var_4_18)
				var_4_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_17.position).x, (manager.ui.mainCamera.transform.position - var_4_17.position).y, (manager.ui.mainCamera.transform.position - var_4_17.position).z)
				var_4_17.localEulerAngles.z = 0
				var_4_17.localEulerAngles.x = 0
				var_4_17.localEulerAngles = var_4_17.localEulerAngles
			end

			if arg_1_1.time_ >= 1.5 + var_4_18 and arg_1_1.time_ < 1.5 + var_4_18 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(-0.7, -1.1, -5.6)
				var_4_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_17.position).x, (manager.ui.mainCamera.transform.position - var_4_17.position).y, (manager.ui.mainCamera.transform.position - var_4_17.position).z)
				var_4_17.localEulerAngles.z = 0
				var_4_17.localEulerAngles.x = 0
				var_4_17.localEulerAngles = var_4_17.localEulerAngles
			end

			local var_4_19 = "10003ui_story"

			if arg_1_1.actors_["10003ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10003ui_story"))) then
				local var_4_20 = Object.Instantiate(Asset.Load("Char/" .. "10003ui_story"), arg_1_1.stage_.transform)

				var_4_20.name = var_4_19
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_19] = var_4_20

				local var_4_21 = var_4_20:GetComponentInChildren(typeof(CharacterEffect))

				var_4_21.enabled = true

				local var_4_22 = GameObjectTools.GetOrAddComponent(var_4_20, typeof(DynamicBoneHelper))

				if var_4_22 then
					var_4_22:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_21.transform, false)

				arg_1_1.var_[var_4_19 .. "Animator"] = var_4_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_19 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_19 .. "LipSync"] = var_4_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_23 = arg_1_1.actors_["10003ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos10003ui_story = var_4_23.localPosition
			end

			local var_4_24 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_24 then
				var_4_23.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10003ui_story, Vector3.New(0, 100, 0), (arg_1_1.time_ - 0) / var_4_24)
				var_4_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_23.position).x, (manager.ui.mainCamera.transform.position - var_4_23.position).y, (manager.ui.mainCamera.transform.position - var_4_23.position).z)
				var_4_23.localEulerAngles.z = 0
				var_4_23.localEulerAngles.x = 0
				var_4_23.localEulerAngles = var_4_23.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_24 and arg_1_1.time_ < 0 + var_4_24 + arg_4_0 then
				var_4_23.localPosition = Vector3.New(0, 100, 0)
				var_4_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_23.position).x, (manager.ui.mainCamera.transform.position - var_4_23.position).y, (manager.ui.mainCamera.transform.position - var_4_23.position).z)
				var_4_23.localEulerAngles.z = 0
				var_4_23.localEulerAngles.x = 0
				var_4_23.localEulerAngles = var_4_23.localEulerAngles
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action2_1")
			end

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action3_1")
			end

			local var_4_25 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_25 + 2 and arg_1_1.time_ < var_4_25 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_26 = 2
			local var_4_27 = 0.975

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_28 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_28:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(109061001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 39 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 39)

				if (39 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 39)) > 0 and var_4_27 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_26 = var_4_26 + 0.3

					if var_4_32 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_26
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061001", "story_v_out_109061.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_109061", "109061001", "story_v_out_109061.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_109061", "109061001", "story_v_out_109061.awb")

						arg_1_1:RecordAudio("109061001", var_4_34)
						arg_1_1:RecordAudio("109061001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_109061", "109061001", "story_v_out_109061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_109061", "109061001", "story_v_out_109061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_35 = var_4_26 + 0.3
			local var_4_36 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_26 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_35) / var_4_36

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play109061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109061002
		arg_8_1.duration_ = 5.03

		local var_8_0 = {
			ja = 5.033,
			ko = 2.8,
			zh = 4.433,
			en = 3.5
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play109061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["10004ui_story"]) and arg_8_1.var_.characterEffect10004ui_story == nil then
				arg_8_1.var_.characterEffect10004ui_story = arg_8_1.actors_["10004ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["10004ui_story"]) then
				if arg_8_1.var_.characterEffect10004ui_story and not isNil(arg_8_1.actors_["10004ui_story"]) then
					arg_8_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["10004ui_story"]) and arg_8_1.var_.characterEffect10004ui_story then
				arg_8_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 0.425

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[157].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2032")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(109061002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 17 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 17)

				if (17 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 17)) > 0 and var_11_2 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061002", "story_v_out_109061.awb") ~= 0 then
					local var_11_7 = manager.audio:GetVoiceLength("story_v_out_109061", "109061002", "story_v_out_109061.awb") / 1000

					if var_11_7 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_1
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_109061", "109061002", "story_v_out_109061.awb")

						arg_8_1:RecordAudio("109061002", var_11_8)
						arg_8_1:RecordAudio("109061002", var_11_8)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_109061", "109061002", "story_v_out_109061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_109061", "109061002", "story_v_out_109061.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_9 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_9 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_9

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_9 and arg_8_1.time_ < var_11_1 + var_11_9 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play109061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109061003
		arg_12_1.duration_ = 10.6

		local var_12_0 = {
			ja = 10.6,
			ko = 6.8,
			zh = 6.9,
			en = 7.6
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
				arg_12_0:Play109061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos10003ui_story = arg_12_1.actors_["10003ui_story"].transform.localPosition
			end

			local var_15_0 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 then
				arg_12_1.actors_["10003ui_story"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10003ui_story, Vector3.New(0.7, -1.05, -5.9), (arg_12_1.time_ - 0) / var_15_0)
				arg_12_1.actors_["10003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["10003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["10003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["10003ui_story"].transform.position).z)
				arg_12_1.actors_["10003ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["10003ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["10003ui_story"].transform.localEulerAngles = arg_12_1.actors_["10003ui_story"].transform.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 then
				arg_12_1.actors_["10003ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -5.9)
				arg_12_1.actors_["10003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["10003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["10003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["10003ui_story"].transform.position).z)
				arg_12_1.actors_["10003ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["10003ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["10003ui_story"].transform.localEulerAngles = arg_12_1.actors_["10003ui_story"].transform.localEulerAngles
			end

			local var_15_1 = arg_12_1.actors_["10004ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_1) and arg_12_1.var_.characterEffect10004ui_story == nil then
				arg_12_1.var_.characterEffect10004ui_story = var_15_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_2 and not isNil(var_15_1) then
				if arg_12_1.var_.characterEffect10004ui_story and not isNil(var_15_1) then
					arg_12_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_12_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_2)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_2 and arg_12_1.time_ < 0 + var_15_2 + arg_15_0 and not isNil(var_15_1) and arg_12_1.var_.characterEffect10004ui_story then
				arg_12_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_12_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_15_3 = arg_12_1.actors_["10003ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect10003ui_story == nil then
				arg_12_1.var_.characterEffect10003ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect10003ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect10003ui_story then
				arg_12_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_15_6 = 0
			local var_15_7 = 0.75

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:GetWordFromCfg(109061003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 30 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 30)

				if (30 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 30)) > 0 and var_15_7 < var_15_11 then
					arg_12_1.talkMaxDuration = var_15_11

					if var_15_11 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_11 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061003", "story_v_out_109061.awb") ~= 0 then
					local var_15_12 = manager.audio:GetVoiceLength("story_v_out_109061", "109061003", "story_v_out_109061.awb") / 1000

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end

					if var_15_8.prefab_name ~= "" and arg_12_1.actors_[var_15_8.prefab_name] ~= nil then
						local var_15_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_8.prefab_name].transform, "story_v_out_109061", "109061003", "story_v_out_109061.awb")

						arg_12_1:RecordAudio("109061003", var_15_13)
						arg_12_1:RecordAudio("109061003", var_15_13)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109061", "109061003", "story_v_out_109061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109061", "109061003", "story_v_out_109061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play109061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109061004
		arg_16_1.duration_ = 8.2

		local var_16_0 = {
			ja = 8.2,
			ko = 5.433,
			zh = 5.833,
			en = 6.833
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
				arg_16_0:Play109061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_19_0 = 0
			local var_19_1 = 0.7

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(109061004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 28 <= 0 and var_19_1 or var_19_1 * (utf8.len(var_19_3) / 28)

				if (28 <= 0 and var_19_1 or var_19_1 * (utf8.len(var_19_3) / 28)) > 0 and var_19_1 < var_19_5 then
					arg_16_1.talkMaxDuration = var_19_5

					if var_19_5 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061004", "story_v_out_109061.awb") ~= 0 then
					local var_19_6 = manager.audio:GetVoiceLength("story_v_out_109061", "109061004", "story_v_out_109061.awb") / 1000

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end

					if var_19_2.prefab_name ~= "" and arg_16_1.actors_[var_19_2.prefab_name] ~= nil then
						local var_19_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_2.prefab_name].transform, "story_v_out_109061", "109061004", "story_v_out_109061.awb")

						arg_16_1:RecordAudio("109061004", var_19_7)
						arg_16_1:RecordAudio("109061004", var_19_7)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109061", "109061004", "story_v_out_109061.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109061", "109061004", "story_v_out_109061.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_8 and arg_16_1.time_ < var_19_0 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play109061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109061005
		arg_20_1.duration_ = 13.2

		local var_20_0 = {
			ja = 13.2,
			ko = 9.233,
			zh = 12.033,
			en = 8.6
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play109061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["10004ui_story"]) and arg_20_1.var_.characterEffect10004ui_story == nil then
				arg_20_1.var_.characterEffect10004ui_story = arg_20_1.actors_["10004ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["10004ui_story"]) then
				if arg_20_1.var_.characterEffect10004ui_story and not isNil(arg_20_1.actors_["10004ui_story"]) then
					arg_20_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["10004ui_story"]) and arg_20_1.var_.characterEffect10004ui_story then
				arg_20_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["10003ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect10003ui_story == nil then
				arg_20_1.var_.characterEffect10003ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect10003ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect10003ui_story then
				arg_20_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_23_4 = 0
			local var_23_5 = 0.975

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_6 = arg_20_1:GetWordFromCfg(109061005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 39 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 39)

				if (39 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 39)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061005", "story_v_out_109061.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_109061", "109061005", "story_v_out_109061.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_109061", "109061005", "story_v_out_109061.awb")

						arg_20_1:RecordAudio("109061005", var_23_11)
						arg_20_1:RecordAudio("109061005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_109061", "109061005", "story_v_out_109061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_109061", "109061005", "story_v_out_109061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_4) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_4 + var_23_12 and arg_20_1.time_ < var_23_4 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play109061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109061006
		arg_24_1.duration_ = 2.5

		local var_24_0 = {
			ja = 2.2,
			ko = 1.999999999999,
			zh = 2.3,
			en = 2.5
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
				arg_24_0:Play109061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["3004_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3004_tpose"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_24_1.stage_.transform)

				var_27_0.name = "3004_tpose"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["3004_tpose"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["3004_tpose" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["3004_tpose" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["3004_tpose" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["3004_tpose"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos3004_tpose = var_27_3.localPosition

				local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_4 then
					var_27_4:EnableDynamicBone(false)
				end
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3004_tpose, Vector3.New(0.7, -2.22, -3.1), (arg_24_1.time_ - 0) / var_27_5)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(0.7, -2.22, -3.1)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(true)
				end
			end

			local var_27_7 = arg_24_1.actors_["3004_tpose"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect3004_tpose == nil then
				arg_24_1.var_.characterEffect3004_tpose = var_27_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_8 = 0.100000001490116

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 and not isNil(var_27_7) then
				if arg_24_1.var_.characterEffect3004_tpose and not isNil(var_27_7) then
					arg_24_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect3004_tpose then
				arg_24_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_27_10 = arg_24_1.actors_["10004ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_10) and arg_24_1.var_.characterEffect10004ui_story == nil then
				arg_24_1.var_.characterEffect10004ui_story = var_27_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_11 and not isNil(var_27_10) then
				if arg_24_1.var_.characterEffect10004ui_story and not isNil(var_27_10) then
					arg_24_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_11)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_11 and arg_24_1.time_ < 0 + var_27_11 + arg_27_0 and not isNil(var_27_10) and arg_24_1.var_.characterEffect10004ui_story then
				arg_24_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_27_12 = arg_24_1.actors_["10003ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10003ui_story = var_27_12.localPosition
			end

			local var_27_13 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_13 then
				var_27_12.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10003ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_13)
				var_27_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_12.position).x, (manager.ui.mainCamera.transform.position - var_27_12.position).y, (manager.ui.mainCamera.transform.position - var_27_12.position).z)
				var_27_12.localEulerAngles.z = 0
				var_27_12.localEulerAngles.x = 0
				var_27_12.localEulerAngles = var_27_12.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_13 and arg_24_1.time_ < 0 + var_27_13 + arg_27_0 then
				var_27_12.localPosition = Vector3.New(0, 100, 0)
				var_27_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_12.position).x, (manager.ui.mainCamera.transform.position - var_27_12.position).y, (manager.ui.mainCamera.transform.position - var_27_12.position).z)
				var_27_12.localEulerAngles.z = 0
				var_27_12.localEulerAngles.x = 0
				var_27_12.localEulerAngles = var_27_12.localEulerAngles
			end

			local var_27_14 = 0
			local var_27_15 = 0.175

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_16 = arg_24_1:GetWordFromCfg(109061006)
				local var_27_17 = arg_24_1:FormatText(var_27_16.content)

				arg_24_1.text_.text = var_27_17

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_19 = 7 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 7)

				if (7 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 7)) > 0 and var_27_15 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_14
					end
				end

				arg_24_1.text_.text = var_27_17
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061006", "story_v_out_109061.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_109061", "109061006", "story_v_out_109061.awb") / 1000

					if var_27_20 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_14
					end

					if var_27_16.prefab_name ~= "" and arg_24_1.actors_[var_27_16.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_16.prefab_name].transform, "story_v_out_109061", "109061006", "story_v_out_109061.awb")

						arg_24_1:RecordAudio("109061006", var_27_21)
						arg_24_1:RecordAudio("109061006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109061", "109061006", "story_v_out_109061.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109061", "109061006", "story_v_out_109061.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_15, arg_24_1.talkMaxDuration)

			if var_27_14 <= arg_24_1.time_ and arg_24_1.time_ < var_27_14 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_14) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_14 + var_27_22 and arg_24_1.time_ < var_27_14 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play109061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109061007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play109061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["3004_tpose"]) and arg_28_1.var_.characterEffect3004_tpose == nil then
				arg_28_1.var_.characterEffect3004_tpose = arg_28_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.100000001490116

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["3004_tpose"]) then
				if arg_28_1.var_.characterEffect3004_tpose and not isNil(arg_28_1.actors_["3004_tpose"]) then
					arg_28_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_28_1.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["3004_tpose"]) and arg_28_1.var_.characterEffect3004_tpose then
				arg_28_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_28_1.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			local var_31_1 = arg_28_1.actors_["10004ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect10004ui_story == nil then
				arg_28_1.var_.characterEffect10004ui_story = var_31_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 and not isNil(var_31_1) then
				if arg_28_1.var_.characterEffect10004ui_story and not isNil(var_31_1) then
					arg_28_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect10004ui_story then
				arg_28_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action3_2")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_4 = 0
			local var_31_5 = 0.1

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(109061007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 4 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 4)

				if (4 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 4)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061007", "story_v_out_109061.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_109061", "109061007", "story_v_out_109061.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_109061", "109061007", "story_v_out_109061.awb")

						arg_28_1:RecordAudio("109061007", var_31_11)
						arg_28_1:RecordAudio("109061007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_109061", "109061007", "story_v_out_109061.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_109061", "109061007", "story_v_out_109061.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play109061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 109061008
		arg_32_1.duration_ = 4.57

		local var_32_0 = {
			ja = 2.8,
			ko = 4.566,
			zh = 4.166,
			en = 4
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play109061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["3004_tpose"]) and arg_32_1.var_.characterEffect3004_tpose == nil then
				arg_32_1.var_.characterEffect3004_tpose = arg_32_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.100000001490116

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["3004_tpose"]) then
				if arg_32_1.var_.characterEffect3004_tpose and not isNil(arg_32_1.actors_["3004_tpose"]) then
					arg_32_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["3004_tpose"]) and arg_32_1.var_.characterEffect3004_tpose then
				arg_32_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["10004ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect10004ui_story == nil then
				arg_32_1.var_.characterEffect10004ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect10004ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_32_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect10004ui_story then
				arg_32_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_32_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_35_4 = 0
			local var_35_5 = 0.4

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(109061008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 16 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 16)

				if (16 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 16)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061008", "story_v_out_109061.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_109061", "109061008", "story_v_out_109061.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_109061", "109061008", "story_v_out_109061.awb")

						arg_32_1:RecordAudio("109061008", var_35_11)
						arg_32_1:RecordAudio("109061008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_109061", "109061008", "story_v_out_109061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_109061", "109061008", "story_v_out_109061.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play109061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 109061009
		arg_36_1.duration_ = 5.77

		local var_36_0 = {
			ja = 5.766,
			ko = 3.9,
			zh = 4.4,
			en = 3.266
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play109061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.45

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(109061009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 18 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 18)

				if (18 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 18)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061009", "story_v_out_109061.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_109061", "109061009", "story_v_out_109061.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_109061", "109061009", "story_v_out_109061.awb")

						arg_36_1:RecordAudio("109061009", var_39_6)
						arg_36_1:RecordAudio("109061009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_109061", "109061009", "story_v_out_109061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_109061", "109061009", "story_v_out_109061.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play109061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 109061010
		arg_40_1.duration_ = 6.63

		local var_40_0 = {
			ja = 5.133,
			ko = 5.533,
			zh = 6.633,
			en = 4.4
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play109061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0.5 < arg_40_1.time_ and arg_40_1.time_ <= 0.5 + arg_43_0 then
				arg_40_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_43_0 = 0.2

			if 0.5 <= arg_40_1.time_ and arg_40_1.time_ < 0.5 + var_43_0 then
				local var_43_1, var_43_2 = math.modf((arg_40_1.time_ - 0.5) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_43_2 * 0.13, var_43_2 * 0.13, var_43_2 * 0.13) + arg_40_1.var_.shakeOldPos
			end

			if arg_40_1.time_ >= 0.5 + var_43_0 and arg_40_1.time_ < 0.5 + var_43_0 + arg_43_0 then
				manager.ui.mainCamera.transform.localPosition = arg_40_1.var_.shakeOldPos
			end

			local var_43_3 = arg_40_1.actors_["3004_tpose"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_3) and arg_40_1.var_.characterEffect3004_tpose == nil then
				arg_40_1.var_.characterEffect3004_tpose = var_43_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_4 = 0.100000001490116

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 and not isNil(var_43_3) then
				if arg_40_1.var_.characterEffect3004_tpose and not isNil(var_43_3) then
					arg_40_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_40_1.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_4)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 and not isNil(var_43_3) and arg_40_1.var_.characterEffect3004_tpose then
				arg_40_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_40_1.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			local var_43_5 = 0
			local var_43_6 = 0.65

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_7 = arg_40_1:GetWordFromCfg(109061010)
				local var_43_8 = arg_40_1:FormatText(var_43_7.content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_10 = 26 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 26)

				if (26 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 26)) > 0 and var_43_6 < var_43_10 then
					arg_40_1.talkMaxDuration = var_43_10

					if var_43_10 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_5
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061010", "story_v_out_109061.awb") ~= 0 then
					local var_43_11 = manager.audio:GetVoiceLength("story_v_out_109061", "109061010", "story_v_out_109061.awb") / 1000

					if var_43_11 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_5
					end

					if var_43_7.prefab_name ~= "" and arg_40_1.actors_[var_43_7.prefab_name] ~= nil then
						local var_43_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_7.prefab_name].transform, "story_v_out_109061", "109061010", "story_v_out_109061.awb")

						arg_40_1:RecordAudio("109061010", var_43_12)
						arg_40_1:RecordAudio("109061010", var_43_12)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_109061", "109061010", "story_v_out_109061.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_109061", "109061010", "story_v_out_109061.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_13 = math.max(var_43_6, arg_40_1.talkMaxDuration)

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_13 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_5) / var_43_13

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_5 + var_43_13 and arg_40_1.time_ < var_43_5 + var_43_13 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play109061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 109061011
		arg_44_1.duration_ = 2.9

		local var_44_0 = {
			ja = 2.866,
			ko = 1.999999999999,
			zh = 2.9,
			en = 2.366
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play109061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["3004_tpose"]) and arg_44_1.var_.characterEffect3004_tpose == nil then
				arg_44_1.var_.characterEffect3004_tpose = arg_44_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.100000001490116

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["3004_tpose"]) then
				if arg_44_1.var_.characterEffect3004_tpose and not isNil(arg_44_1.actors_["3004_tpose"]) then
					arg_44_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_44_1.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["3004_tpose"]) and arg_44_1.var_.characterEffect3004_tpose then
				arg_44_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_44_1.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			local var_47_1 = arg_44_1.actors_["10004ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect10004ui_story == nil then
				arg_44_1.var_.characterEffect10004ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect10004ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect10004ui_story then
				arg_44_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_4 = 0
			local var_47_5 = 0.175

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(109061011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 7 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 7)

				if (7 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 7)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061011", "story_v_out_109061.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_109061", "109061011", "story_v_out_109061.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_109061", "109061011", "story_v_out_109061.awb")

						arg_44_1:RecordAudio("109061011", var_47_11)
						arg_44_1:RecordAudio("109061011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_109061", "109061011", "story_v_out_109061.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_109061", "109061011", "story_v_out_109061.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play109061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109061012
		arg_48_1.duration_ = 8.27

		local var_48_0 = {
			ja = 8.266,
			ko = 7.233,
			zh = 7.366,
			en = 6.766
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
				arg_48_0:Play109061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["3004_tpose"]) and arg_48_1.var_.characterEffect3004_tpose == nil then
				arg_48_1.var_.characterEffect3004_tpose = arg_48_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["3004_tpose"]) then
				if arg_48_1.var_.characterEffect3004_tpose and not isNil(arg_48_1.actors_["3004_tpose"]) then
					arg_48_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["3004_tpose"]) and arg_48_1.var_.characterEffect3004_tpose then
				arg_48_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["10004ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect10004ui_story == nil then
				arg_48_1.var_.characterEffect10004ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect10004ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect10004ui_story then
				arg_48_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_51_4 = 0
			local var_51_5 = 0.775

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(109061012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 31 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 31)

				if (31 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 31)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061012", "story_v_out_109061.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_109061", "109061012", "story_v_out_109061.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_109061", "109061012", "story_v_out_109061.awb")

						arg_48_1:RecordAudio("109061012", var_51_11)
						arg_48_1:RecordAudio("109061012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_109061", "109061012", "story_v_out_109061.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_109061", "109061012", "story_v_out_109061.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play109061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 109061013
		arg_52_1.duration_ = 1.8

		local var_52_0 = {
			ja = 1.8,
			ko = 1.2,
			zh = 1.533,
			en = 1.633
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play109061014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["3004_tpose"]) and arg_52_1.var_.characterEffect3004_tpose == nil then
				arg_52_1.var_.characterEffect3004_tpose = arg_52_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.100000001490116

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["3004_tpose"]) then
				if arg_52_1.var_.characterEffect3004_tpose and not isNil(arg_52_1.actors_["3004_tpose"]) then
					arg_52_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_52_1.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["3004_tpose"]) and arg_52_1.var_.characterEffect3004_tpose then
				arg_52_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_52_1.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.125

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(109061013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 5 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 5)

				if (5 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 5)) > 0 and var_55_2 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061013", "story_v_out_109061.awb") ~= 0 then
					local var_55_7 = manager.audio:GetVoiceLength("story_v_out_109061", "109061013", "story_v_out_109061.awb") / 1000

					if var_55_7 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_1
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_109061", "109061013", "story_v_out_109061.awb")

						arg_52_1:RecordAudio("109061013", var_55_8)
						arg_52_1:RecordAudio("109061013", var_55_8)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_109061", "109061013", "story_v_out_109061.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_109061", "109061013", "story_v_out_109061.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_9 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_9 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_9

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_9 and arg_52_1.time_ < var_55_1 + var_55_9 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play109061014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 109061014
		arg_56_1.duration_ = 6.7

		local var_56_0 = {
			ja = 3.966,
			ko = 3.5,
			zh = 3.233,
			en = 6.7
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play109061015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.3

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:GetWordFromCfg(109061014)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 12 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 12)

				if (12 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 12)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061014", "story_v_out_109061.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_109061", "109061014", "story_v_out_109061.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_109061", "109061014", "story_v_out_109061.awb")

						arg_56_1:RecordAudio("109061014", var_59_6)
						arg_56_1:RecordAudio("109061014", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_109061", "109061014", "story_v_out_109061.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_109061", "109061014", "story_v_out_109061.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play109061015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 109061015
		arg_60_1.duration_ = 5

		local var_60_0 = {
			ja = 4.466,
			ko = 5,
			zh = 4.166,
			en = 4.7
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play109061016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.45

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:GetWordFromCfg(109061015)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 18 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 18)

				if (18 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 18)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061015", "story_v_out_109061.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_109061", "109061015", "story_v_out_109061.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_109061", "109061015", "story_v_out_109061.awb")

						arg_60_1:RecordAudio("109061015", var_63_6)
						arg_60_1:RecordAudio("109061015", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_109061", "109061015", "story_v_out_109061.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_109061", "109061015", "story_v_out_109061.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play109061016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 109061016
		arg_64_1.duration_ = 6.8

		local var_64_0 = {
			ja = 5.2,
			ko = 4.3,
			zh = 6.366,
			en = 6.8
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play109061017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.825

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:GetWordFromCfg(109061016)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 33 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 33)

				if (33 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 33)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061016", "story_v_out_109061.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_109061", "109061016", "story_v_out_109061.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_109061", "109061016", "story_v_out_109061.awb")

						arg_64_1:RecordAudio("109061016", var_67_6)
						arg_64_1:RecordAudio("109061016", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_109061", "109061016", "story_v_out_109061.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_109061", "109061016", "story_v_out_109061.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play109061017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 109061017
		arg_68_1.duration_ = 3.4

		local var_68_0 = {
			ja = 2.833,
			ko = 2.166,
			zh = 3.366,
			en = 3.4
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play109061018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["3004_tpose"]) and arg_68_1.var_.characterEffect3004_tpose == nil then
				arg_68_1.var_.characterEffect3004_tpose = arg_68_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["3004_tpose"]) then
				if arg_68_1.var_.characterEffect3004_tpose and not isNil(arg_68_1.actors_["3004_tpose"]) then
					arg_68_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["3004_tpose"]) and arg_68_1.var_.characterEffect3004_tpose then
				arg_68_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_71_2 = 0
			local var_71_3 = 0.175

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(109061017)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 7 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 7)

				if (7 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 7)) > 0 and var_71_3 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061017", "story_v_out_109061.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_109061", "109061017", "story_v_out_109061.awb") / 1000

					if var_71_8 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_2
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_out_109061", "109061017", "story_v_out_109061.awb")

						arg_68_1:RecordAudio("109061017", var_71_9)
						arg_68_1:RecordAudio("109061017", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_109061", "109061017", "story_v_out_109061.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_109061", "109061017", "story_v_out_109061.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_10 and arg_68_1.time_ < var_71_2 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play109061018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 109061018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play109061019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.475

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(109061018).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 19 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 19)

				if (19 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 19)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play109061019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 109061019
		arg_76_1.duration_ = 4.07

		local var_76_0 = {
			ja = 4.066,
			ko = 2.6,
			zh = 2.466,
			en = 3.233
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play109061020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0.1 < arg_76_1.time_ and arg_76_1.time_ <= 0.1 + arg_79_0 then
				arg_76_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_79_0 = 0.8

			if 0.1 <= arg_76_1.time_ and arg_76_1.time_ < 0.1 + var_79_0 then
				local var_79_1, var_79_2 = math.modf((arg_76_1.time_ - 0.1) / 0.099)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_79_2 * 0.13, var_79_2 * 0.13, var_79_2 * 0.13) + arg_76_1.var_.shakeOldPos
			end

			if arg_76_1.time_ >= 0.1 + var_79_0 and arg_76_1.time_ < 0.1 + var_79_0 + arg_79_0 then
				manager.ui.mainCamera.transform.localPosition = arg_76_1.var_.shakeOldPos
			end

			local var_79_3 = 0
			local var_79_4 = 0.2

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_3 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_5 = arg_76_1:GetWordFromCfg(109061019)
				local var_79_6 = arg_76_1:FormatText(var_79_5.content)

				arg_76_1.text_.text = var_79_6

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_8 = 8 <= 0 and var_79_4 or var_79_4 * (utf8.len(var_79_6) / 8)

				if (8 <= 0 and var_79_4 or var_79_4 * (utf8.len(var_79_6) / 8)) > 0 and var_79_4 < var_79_8 then
					arg_76_1.talkMaxDuration = var_79_8

					if var_79_8 + var_79_3 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_3
					end
				end

				arg_76_1.text_.text = var_79_6
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061019", "story_v_out_109061.awb") ~= 0 then
					local var_79_9 = manager.audio:GetVoiceLength("story_v_out_109061", "109061019", "story_v_out_109061.awb") / 1000

					if var_79_9 + var_79_3 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_3
					end

					if var_79_5.prefab_name ~= "" and arg_76_1.actors_[var_79_5.prefab_name] ~= nil then
						local var_79_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_5.prefab_name].transform, "story_v_out_109061", "109061019", "story_v_out_109061.awb")

						arg_76_1:RecordAudio("109061019", var_79_10)
						arg_76_1:RecordAudio("109061019", var_79_10)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_109061", "109061019", "story_v_out_109061.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_109061", "109061019", "story_v_out_109061.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_11 = math.max(var_79_4, arg_76_1.talkMaxDuration)

			if var_79_3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_3 + var_79_11 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_3) / var_79_11

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_3 + var_79_11 and arg_76_1.time_ < var_79_3 + var_79_11 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play109061020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 109061020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play109061021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos3004_tpose = arg_80_1.actors_["3004_tpose"].transform.localPosition

				local var_83_0 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_0 then
					var_83_0:EnableDynamicBone(false)
				end
			end

			local var_83_1 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_1 then
				arg_80_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_1)
				arg_80_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["3004_tpose"].transform.position).z)
				arg_80_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["3004_tpose"].transform.localEulerAngles = arg_80_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_1 and arg_80_1.time_ < 0 + var_83_1 + arg_83_0 then
				arg_80_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["3004_tpose"].transform.position).z)
				arg_80_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["3004_tpose"].transform.localEulerAngles = arg_80_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_83_2 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(true)
				end
			end

			local var_83_3 = arg_80_1.actors_["10004ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10004ui_story = var_83_3.localPosition
			end

			local var_83_4 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				var_83_3.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10004ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_4)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				var_83_3.localPosition = Vector3.New(0, 100, 0)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			local var_83_5 = 0
			local var_83_6 = 0.925

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_7 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_7:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_8 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(109061020).content)

				arg_80_1.text_.text = var_83_8

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_10 = 37 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 37)

				if (37 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 37)) > 0 and var_83_6 < var_83_10 then
					arg_80_1.talkMaxDuration = var_83_10
					var_83_5 = var_83_5 + 0.3

					if var_83_10 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_5
					end
				end

				arg_80_1.text_.text = var_83_8
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_11 = var_83_5 + 0.3
			local var_83_12 = math.max(var_83_6, arg_80_1.talkMaxDuration)

			if var_83_5 + 0.3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_11 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_11) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_11 + var_83_12 and arg_80_1.time_ < var_83_11 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play109061021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 109061021
		arg_86_1.duration_ = 2.8

		local var_86_0 = {
			ja = 2.5,
			ko = 2.1,
			zh = 2.8,
			en = 2.466
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play109061022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if arg_86_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_89_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_86_1.stage_.transform)

				var_89_0.name = "1084ui_story"
				var_89_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_["1084ui_story"] = var_89_0

				local var_89_1 = var_89_0:GetComponentInChildren(typeof(CharacterEffect))

				var_89_1.enabled = true

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_0, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end

				arg_86_1:ShowWeapon(var_89_1.transform, false)

				arg_86_1.var_["1084ui_story" .. "Animator"] = var_89_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_86_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_86_1.var_["1084ui_story" .. "LipSync"] = var_89_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_89_3 = arg_86_1.actors_["1084ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1084ui_story = var_89_3.localPosition
			end

			local var_89_4 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				var_89_3.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_86_1.time_ - 0) / var_89_4)
				var_89_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_3.position).x, (manager.ui.mainCamera.transform.position - var_89_3.position).y, (manager.ui.mainCamera.transform.position - var_89_3.position).z)
				var_89_3.localEulerAngles.z = 0
				var_89_3.localEulerAngles.x = 0
				var_89_3.localEulerAngles = var_89_3.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				var_89_3.localPosition = Vector3.New(0, -0.97, -6)
				var_89_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_3.position).x, (manager.ui.mainCamera.transform.position - var_89_3.position).y, (manager.ui.mainCamera.transform.position - var_89_3.position).z)
				var_89_3.localEulerAngles.z = 0
				var_89_3.localEulerAngles.x = 0
				var_89_3.localEulerAngles = var_89_3.localEulerAngles
			end

			local var_89_5 = arg_86_1.actors_["1084ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = var_89_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_6 and not isNil(var_89_5) then
				if arg_86_1.var_.characterEffect1084ui_story and not isNil(var_89_5) then
					arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_6 and arg_86_1.time_ < 0 + var_89_6 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect1084ui_story then
				arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_89_8 = 0
			local var_89_9 = 0.25

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_10 = arg_86_1:GetWordFromCfg(109061021)
				local var_89_11 = arg_86_1:FormatText(var_89_10.content)

				arg_86_1.text_.text = var_89_11

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 10 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_11) / 10)

				if (10 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_11) / 10)) > 0 and var_89_9 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_8
					end
				end

				arg_86_1.text_.text = var_89_11
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061021", "story_v_out_109061.awb") ~= 0 then
					local var_89_14 = manager.audio:GetVoiceLength("story_v_out_109061", "109061021", "story_v_out_109061.awb") / 1000

					if var_89_14 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_8
					end

					if var_89_10.prefab_name ~= "" and arg_86_1.actors_[var_89_10.prefab_name] ~= nil then
						local var_89_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_10.prefab_name].transform, "story_v_out_109061", "109061021", "story_v_out_109061.awb")

						arg_86_1:RecordAudio("109061021", var_89_15)
						arg_86_1:RecordAudio("109061021", var_89_15)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_109061", "109061021", "story_v_out_109061.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_109061", "109061021", "story_v_out_109061.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_9, arg_86_1.talkMaxDuration)

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_8) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_8 + var_89_16 and arg_86_1.time_ < var_89_8 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play109061022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 109061022
		arg_90_1.duration_ = 7.47

		local var_90_0 = {
			ja = 7.466,
			ko = 6.233,
			zh = 6.6,
			en = 6.966
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play109061023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.4

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_1 = arg_90_1:GetWordFromCfg(109061022)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 16 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 16)

				if (16 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 16)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061022", "story_v_out_109061.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_109061", "109061022", "story_v_out_109061.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_109061", "109061022", "story_v_out_109061.awb")

						arg_90_1:RecordAudio("109061022", var_93_6)
						arg_90_1:RecordAudio("109061022", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_109061", "109061022", "story_v_out_109061.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_109061", "109061022", "story_v_out_109061.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play109061023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 109061023
		arg_94_1.duration_ = 9.53

		local var_94_0 = {
			ja = 5.933,
			ko = 6.633,
			zh = 8.3,
			en = 9.533
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play109061024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1084ui_story = arg_94_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_97_0 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 then
				arg_94_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_94_1.time_ - 0) / var_97_0)
				arg_94_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).z)
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles = arg_94_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 then
				arg_94_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).z)
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles = arg_94_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_97_1 = arg_94_1.actors_["3004_tpose"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos3004_tpose = var_97_1.localPosition

				local var_97_2 = GameObjectTools.GetOrAddComponent(var_97_1.gameObject, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(false)
				end
			end

			local var_97_3 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 then
				var_97_1.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_94_1.time_ - 0) / var_97_3)
				var_97_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_1.position).x, (manager.ui.mainCamera.transform.position - var_97_1.position).y, (manager.ui.mainCamera.transform.position - var_97_1.position).z)
				var_97_1.localEulerAngles.z = 0
				var_97_1.localEulerAngles.x = 0
				var_97_1.localEulerAngles = var_97_1.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 then
				var_97_1.localPosition = Vector3.New(0, -2.22, -3.1)
				var_97_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_1.position).x, (manager.ui.mainCamera.transform.position - var_97_1.position).y, (manager.ui.mainCamera.transform.position - var_97_1.position).z)
				var_97_1.localEulerAngles.z = 0
				var_97_1.localEulerAngles.x = 0
				var_97_1.localEulerAngles = var_97_1.localEulerAngles

				local var_97_4 = GameObjectTools.GetOrAddComponent(var_97_1.gameObject, typeof(DynamicBoneHelper))

				if var_97_4 then
					var_97_4:EnableDynamicBone(true)
				end
			end

			local var_97_5 = arg_94_1.actors_["3004_tpose"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect3004_tpose == nil then
				arg_94_1.var_.characterEffect3004_tpose = var_97_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_6 and not isNil(var_97_5) then
				if arg_94_1.var_.characterEffect3004_tpose and not isNil(var_97_5) then
					arg_94_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_6 and arg_94_1.time_ < 0 + var_97_6 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect3004_tpose then
				arg_94_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_97_8 = 0
			local var_97_9 = 0.7

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:GetWordFromCfg(109061023)
				local var_97_11 = arg_94_1:FormatText(var_97_10.content)

				arg_94_1.text_.text = var_97_11

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 28 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 28)

				if (28 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 28)) > 0 and var_97_9 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_11
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061023", "story_v_out_109061.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_109061", "109061023", "story_v_out_109061.awb") / 1000

					if var_97_14 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_8
					end

					if var_97_10.prefab_name ~= "" and arg_94_1.actors_[var_97_10.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_10.prefab_name].transform, "story_v_out_109061", "109061023", "story_v_out_109061.awb")

						arg_94_1:RecordAudio("109061023", var_97_15)
						arg_94_1:RecordAudio("109061023", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_109061", "109061023", "story_v_out_109061.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_109061", "109061023", "story_v_out_109061.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_16 and arg_94_1.time_ < var_97_8 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play109061024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 109061024
		arg_98_1.duration_ = 4.63

		local var_98_0 = {
			ja = 2.466,
			ko = 2.8,
			zh = 3.7,
			en = 4.633
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play109061025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos3004_tpose = arg_98_1.actors_["3004_tpose"].transform.localPosition

				local var_101_0 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_0 then
					var_101_0:EnableDynamicBone(false)
				end
			end

			local var_101_1 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_1 then
				arg_98_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_1)
				arg_98_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["3004_tpose"].transform.position).z)
				arg_98_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["3004_tpose"].transform.localEulerAngles = arg_98_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_1 and arg_98_1.time_ < 0 + var_101_1 + arg_101_0 then
				arg_98_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["3004_tpose"].transform.position).z)
				arg_98_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["3004_tpose"].transform.localEulerAngles = arg_98_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_101_2 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(true)
				end
			end

			local var_101_3 = "1099ui_story"

			if arg_98_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_101_4 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_98_1.stage_.transform)

				var_101_4.name = var_101_3
				var_101_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_[var_101_3] = var_101_4

				local var_101_5 = var_101_4:GetComponentInChildren(typeof(CharacterEffect))

				var_101_5.enabled = true

				local var_101_6 = GameObjectTools.GetOrAddComponent(var_101_4, typeof(DynamicBoneHelper))

				if var_101_6 then
					var_101_6:EnableDynamicBone(false)
				end

				arg_98_1:ShowWeapon(var_101_5.transform, false)

				arg_98_1.var_[var_101_3 .. "Animator"] = var_101_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_98_1.var_[var_101_3 .. "Animator"].applyRootMotion = true
				arg_98_1.var_[var_101_3 .. "LipSync"] = var_101_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_101_7 = arg_98_1.actors_["1099ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1099ui_story = var_101_7.localPosition
			end

			local var_101_8 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_8 then
				var_101_7.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_98_1.time_ - 0) / var_101_8)
				var_101_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_7.position).x, (manager.ui.mainCamera.transform.position - var_101_7.position).y, (manager.ui.mainCamera.transform.position - var_101_7.position).z)
				var_101_7.localEulerAngles.z = 0
				var_101_7.localEulerAngles.x = 0
				var_101_7.localEulerAngles = var_101_7.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_8 and arg_98_1.time_ < 0 + var_101_8 + arg_101_0 then
				var_101_7.localPosition = Vector3.New(0, -1.08, -5.9)
				var_101_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_7.position).x, (manager.ui.mainCamera.transform.position - var_101_7.position).y, (manager.ui.mainCamera.transform.position - var_101_7.position).z)
				var_101_7.localEulerAngles.z = 0
				var_101_7.localEulerAngles.x = 0
				var_101_7.localEulerAngles = var_101_7.localEulerAngles
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			local var_101_9 = arg_98_1.actors_["1099ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect1099ui_story == nil then
				arg_98_1.var_.characterEffect1099ui_story = var_101_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_10 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_10 and not isNil(var_101_9) then
				if arg_98_1.var_.characterEffect1099ui_story and not isNil(var_101_9) then
					arg_98_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_10 and arg_98_1.time_ < 0 + var_101_10 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect1099ui_story then
				arg_98_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_101_12 = 0
			local var_101_13 = 0.425

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_14 = arg_98_1:GetWordFromCfg(109061024)
				local var_101_15 = arg_98_1:FormatText(var_101_14.content)

				arg_98_1.text_.text = var_101_15

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_17 = 17 <= 0 and var_101_13 or var_101_13 * (utf8.len(var_101_15) / 17)

				if (17 <= 0 and var_101_13 or var_101_13 * (utf8.len(var_101_15) / 17)) > 0 and var_101_13 < var_101_17 then
					arg_98_1.talkMaxDuration = var_101_17

					if var_101_17 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_17 + var_101_12
					end
				end

				arg_98_1.text_.text = var_101_15
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061024", "story_v_out_109061.awb") ~= 0 then
					local var_101_18 = manager.audio:GetVoiceLength("story_v_out_109061", "109061024", "story_v_out_109061.awb") / 1000

					if var_101_18 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_18 + var_101_12
					end

					if var_101_14.prefab_name ~= "" and arg_98_1.actors_[var_101_14.prefab_name] ~= nil then
						local var_101_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_14.prefab_name].transform, "story_v_out_109061", "109061024", "story_v_out_109061.awb")

						arg_98_1:RecordAudio("109061024", var_101_19)
						arg_98_1:RecordAudio("109061024", var_101_19)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_109061", "109061024", "story_v_out_109061.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_109061", "109061024", "story_v_out_109061.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_20 = math.max(var_101_13, arg_98_1.talkMaxDuration)

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_20 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_12) / var_101_20

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_12 + var_101_20 and arg_98_1.time_ < var_101_12 + var_101_20 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play109061025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 109061025
		arg_102_1.duration_ = 8.53

		local var_102_0 = {
			ja = 6.8,
			ko = 4.8,
			zh = 8.533,
			en = 7.466
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play109061026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1099ui_story = arg_102_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1099ui_story"].transform.position).z)
				arg_102_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1099ui_story"].transform.localEulerAngles = arg_102_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1099ui_story"].transform.position).z)
				arg_102_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1099ui_story"].transform.localEulerAngles = arg_102_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["3004_tpose"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos3004_tpose = var_105_1.localPosition

				local var_105_2 = GameObjectTools.GetOrAddComponent(var_105_1.gameObject, typeof(DynamicBoneHelper))

				if var_105_2 then
					var_105_2:EnableDynamicBone(false)
				end
			end

			local var_105_3 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 then
				var_105_1.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_102_1.time_ - 0) / var_105_3)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 then
				var_105_1.localPosition = Vector3.New(0, -2.22, -3.1)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles

				local var_105_4 = GameObjectTools.GetOrAddComponent(var_105_1.gameObject, typeof(DynamicBoneHelper))

				if var_105_4 then
					var_105_4:EnableDynamicBone(true)
				end
			end

			local var_105_5 = arg_102_1.actors_["3004_tpose"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_5) and arg_102_1.var_.characterEffect3004_tpose == nil then
				arg_102_1.var_.characterEffect3004_tpose = var_105_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_6 and not isNil(var_105_5) then
				if arg_102_1.var_.characterEffect3004_tpose and not isNil(var_105_5) then
					arg_102_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_6 and arg_102_1.time_ < 0 + var_105_6 + arg_105_0 and not isNil(var_105_5) and arg_102_1.var_.characterEffect3004_tpose then
				arg_102_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_105_8 = 0
			local var_105_9 = 0.925

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_10 = arg_102_1:GetWordFromCfg(109061025)
				local var_105_11 = arg_102_1:FormatText(var_105_10.content)

				arg_102_1.text_.text = var_105_11

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_13 = 37 <= 0 and var_105_9 or var_105_9 * (utf8.len(var_105_11) / 37)

				if (37 <= 0 and var_105_9 or var_105_9 * (utf8.len(var_105_11) / 37)) > 0 and var_105_9 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_8
					end
				end

				arg_102_1.text_.text = var_105_11
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061025", "story_v_out_109061.awb") ~= 0 then
					local var_105_14 = manager.audio:GetVoiceLength("story_v_out_109061", "109061025", "story_v_out_109061.awb") / 1000

					if var_105_14 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_8
					end

					if var_105_10.prefab_name ~= "" and arg_102_1.actors_[var_105_10.prefab_name] ~= nil then
						local var_105_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_10.prefab_name].transform, "story_v_out_109061", "109061025", "story_v_out_109061.awb")

						arg_102_1:RecordAudio("109061025", var_105_15)
						arg_102_1:RecordAudio("109061025", var_105_15)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_109061", "109061025", "story_v_out_109061.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_109061", "109061025", "story_v_out_109061.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_9, arg_102_1.talkMaxDuration)

			if var_105_8 <= arg_102_1.time_ and arg_102_1.time_ < var_105_8 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_8) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_8 + var_105_16 and arg_102_1.time_ < var_105_8 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play109061026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 109061026
		arg_106_1.duration_ = 3.5

		local var_106_0 = {
			ja = 3.333,
			ko = 3.1,
			zh = 3,
			en = 3.5
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play109061027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos3004_tpose = arg_106_1.actors_["3004_tpose"].transform.localPosition

				local var_109_0 = GameObjectTools.GetOrAddComponent(arg_106_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_109_0 then
					var_109_0:EnableDynamicBone(false)
				end
			end

			local var_109_1 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_1 then
				arg_106_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_106_1.time_ - 0) / var_109_1)
				arg_106_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["3004_tpose"].transform.position).z)
				arg_106_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["3004_tpose"].transform.localEulerAngles = arg_106_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_1 and arg_106_1.time_ < 0 + var_109_1 + arg_109_0 then
				arg_106_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["3004_tpose"].transform.position).z)
				arg_106_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["3004_tpose"].transform.localEulerAngles = arg_106_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_109_2 = GameObjectTools.GetOrAddComponent(arg_106_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(true)
				end
			end

			local var_109_3 = "1050ui_story"

			if arg_106_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_109_4 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_106_1.stage_.transform)

				var_109_4.name = var_109_3
				var_109_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_[var_109_3] = var_109_4

				local var_109_5 = var_109_4:GetComponentInChildren(typeof(CharacterEffect))

				var_109_5.enabled = true

				local var_109_6 = GameObjectTools.GetOrAddComponent(var_109_4, typeof(DynamicBoneHelper))

				if var_109_6 then
					var_109_6:EnableDynamicBone(false)
				end

				arg_106_1:ShowWeapon(var_109_5.transform, false)

				arg_106_1.var_[var_109_3 .. "Animator"] = var_109_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_106_1.var_[var_109_3 .. "Animator"].applyRootMotion = true
				arg_106_1.var_[var_109_3 .. "LipSync"] = var_109_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_109_7 = arg_106_1.actors_["1050ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1050ui_story = var_109_7.localPosition

				arg_106_1:ShowWeapon(arg_106_1.var_["1050ui_story" .. "Animator"].transform, true)
			end

			local var_109_8 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_8 then
				var_109_7.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_106_1.time_ - 0) / var_109_8)
				var_109_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_7.position).x, (manager.ui.mainCamera.transform.position - var_109_7.position).y, (manager.ui.mainCamera.transform.position - var_109_7.position).z)
				var_109_7.localEulerAngles.z = 0
				var_109_7.localEulerAngles.x = 0
				var_109_7.localEulerAngles = var_109_7.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_8 and arg_106_1.time_ < 0 + var_109_8 + arg_109_0 then
				var_109_7.localPosition = Vector3.New(-0.7, -1, -6.1)
				var_109_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_7.position).x, (manager.ui.mainCamera.transform.position - var_109_7.position).y, (manager.ui.mainCamera.transform.position - var_109_7.position).z)
				var_109_7.localEulerAngles.z = 0
				var_109_7.localEulerAngles.x = 0
				var_109_7.localEulerAngles = var_109_7.localEulerAngles
			end

			local var_109_9 = arg_106_1.actors_["1050ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1050ui_story == nil then
				arg_106_1.var_.characterEffect1050ui_story = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_10 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_10 and not isNil(var_109_9) then
				if arg_106_1.var_.characterEffect1050ui_story and not isNil(var_109_9) then
					arg_106_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_10 and arg_106_1.time_ < 0 + var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1050ui_story then
				arg_106_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_109_12 = 0
			local var_109_13 = 0.3

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_14 = arg_106_1:GetWordFromCfg(109061026)
				local var_109_15 = arg_106_1:FormatText(var_109_14.content)

				arg_106_1.text_.text = var_109_15

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_17 = 12 <= 0 and var_109_13 or var_109_13 * (utf8.len(var_109_15) / 12)

				if (12 <= 0 and var_109_13 or var_109_13 * (utf8.len(var_109_15) / 12)) > 0 and var_109_13 < var_109_17 then
					arg_106_1.talkMaxDuration = var_109_17

					if var_109_17 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_17 + var_109_12
					end
				end

				arg_106_1.text_.text = var_109_15
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061026", "story_v_out_109061.awb") ~= 0 then
					local var_109_18 = manager.audio:GetVoiceLength("story_v_out_109061", "109061026", "story_v_out_109061.awb") / 1000

					if var_109_18 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_18 + var_109_12
					end

					if var_109_14.prefab_name ~= "" and arg_106_1.actors_[var_109_14.prefab_name] ~= nil then
						local var_109_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_14.prefab_name].transform, "story_v_out_109061", "109061026", "story_v_out_109061.awb")

						arg_106_1:RecordAudio("109061026", var_109_19)
						arg_106_1:RecordAudio("109061026", var_109_19)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_109061", "109061026", "story_v_out_109061.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_109061", "109061026", "story_v_out_109061.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_20 = math.max(var_109_13, arg_106_1.talkMaxDuration)

			if var_109_12 <= arg_106_1.time_ and arg_106_1.time_ < var_109_12 + var_109_20 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_12) / var_109_20

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_12 + var_109_20 and arg_106_1.time_ < var_109_12 + var_109_20 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play109061027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 109061027
		arg_110_1.duration_ = 5.4

		local var_110_0 = {
			ja = 4.6,
			ko = 5.4,
			zh = 5.3,
			en = 4.8
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play109061028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1099ui_story = arg_110_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_110_1.time_ - 0) / var_113_0)
				arg_110_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1099ui_story"].transform.position).z)
				arg_110_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1099ui_story"].transform.localEulerAngles = arg_110_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_110_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1099ui_story"].transform.position).z)
				arg_110_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1099ui_story"].transform.localEulerAngles = arg_110_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_113_1 = arg_110_1.actors_["1099ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1099ui_story == nil then
				arg_110_1.var_.characterEffect1099ui_story = var_113_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_2 and not isNil(var_113_1) then
				if arg_110_1.var_.characterEffect1099ui_story and not isNil(var_113_1) then
					arg_110_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_2 and arg_110_1.time_ < 0 + var_113_2 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1099ui_story then
				arg_110_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["1050ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1050ui_story == nil then
				arg_110_1.var_.characterEffect1050ui_story = var_113_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_5 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_5 and not isNil(var_113_4) then
				if arg_110_1.var_.characterEffect1050ui_story and not isNil(var_113_4) then
					arg_110_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_5)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_5 and arg_110_1.time_ < 0 + var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1050ui_story then
				arg_110_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_113_6 = 0
			local var_113_7 = 0.625

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_8 = arg_110_1:GetWordFromCfg(109061027)
				local var_113_9 = arg_110_1:FormatText(var_113_8.content)

				arg_110_1.text_.text = var_113_9

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 25 <= 0 and var_113_7 or var_113_7 * (utf8.len(var_113_9) / 25)

				if (25 <= 0 and var_113_7 or var_113_7 * (utf8.len(var_113_9) / 25)) > 0 and var_113_7 < var_113_11 then
					arg_110_1.talkMaxDuration = var_113_11

					if var_113_11 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_11 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_9
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061027", "story_v_out_109061.awb") ~= 0 then
					local var_113_12 = manager.audio:GetVoiceLength("story_v_out_109061", "109061027", "story_v_out_109061.awb") / 1000

					if var_113_12 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_12 + var_113_6
					end

					if var_113_8.prefab_name ~= "" and arg_110_1.actors_[var_113_8.prefab_name] ~= nil then
						local var_113_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_8.prefab_name].transform, "story_v_out_109061", "109061027", "story_v_out_109061.awb")

						arg_110_1:RecordAudio("109061027", var_113_13)
						arg_110_1:RecordAudio("109061027", var_113_13)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_109061", "109061027", "story_v_out_109061.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_109061", "109061027", "story_v_out_109061.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_14 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_14 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_14

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_14 and arg_110_1.time_ < var_113_6 + var_113_14 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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

		arg_110_1:InitPlayNodeList()
	end,
	Play109061028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 109061028
		arg_114_1.duration_ = 6

		local var_114_0 = {
			ja = 4.433,
			ko = 3.2,
			zh = 6,
			en = 3.533
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play109061029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1099ui_story"]) and arg_114_1.var_.characterEffect1099ui_story == nil then
				arg_114_1.var_.characterEffect1099ui_story = arg_114_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1099ui_story"]) then
				if arg_114_1.var_.characterEffect1099ui_story and not isNil(arg_114_1.actors_["1099ui_story"]) then
					arg_114_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_0)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1099ui_story"]) and arg_114_1.var_.characterEffect1099ui_story then
				arg_114_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_117_1 = arg_114_1.actors_["1050ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1050ui_story = var_117_1.localPosition

				arg_114_1:ShowWeapon(arg_114_1.var_["1050ui_story" .. "Animator"].transform, true)
			end

			local var_117_2 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_2 then
				var_117_1.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_2)
				var_117_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_1.position).x, (manager.ui.mainCamera.transform.position - var_117_1.position).y, (manager.ui.mainCamera.transform.position - var_117_1.position).z)
				var_117_1.localEulerAngles.z = 0
				var_117_1.localEulerAngles.x = 0
				var_117_1.localEulerAngles = var_117_1.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_2 and arg_114_1.time_ < 0 + var_117_2 + arg_117_0 then
				var_117_1.localPosition = Vector3.New(0, 100, 0)
				var_117_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_1.position).x, (manager.ui.mainCamera.transform.position - var_117_1.position).y, (manager.ui.mainCamera.transform.position - var_117_1.position).z)
				var_117_1.localEulerAngles.z = 0
				var_117_1.localEulerAngles.x = 0
				var_117_1.localEulerAngles = var_117_1.localEulerAngles
			end

			local var_117_3 = arg_114_1.actors_["1099ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1099ui_story = var_117_3.localPosition
			end

			local var_117_4 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				var_117_3.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_4)
				var_117_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_3.position).x, (manager.ui.mainCamera.transform.position - var_117_3.position).y, (manager.ui.mainCamera.transform.position - var_117_3.position).z)
				var_117_3.localEulerAngles.z = 0
				var_117_3.localEulerAngles.x = 0
				var_117_3.localEulerAngles = var_117_3.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				var_117_3.localPosition = Vector3.New(0, 100, 0)
				var_117_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_3.position).x, (manager.ui.mainCamera.transform.position - var_117_3.position).y, (manager.ui.mainCamera.transform.position - var_117_3.position).z)
				var_117_3.localEulerAngles.z = 0
				var_117_3.localEulerAngles.x = 0
				var_117_3.localEulerAngles = var_117_3.localEulerAngles
			end

			local var_117_5 = arg_114_1.actors_["10004ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos10004ui_story = var_117_5.localPosition
			end

			local var_117_6 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_6 then
				var_117_5.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10004ui_story, Vector3.New(0, -1.1, -5.6), (arg_114_1.time_ - 0) / var_117_6)
				var_117_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_5.position).x, (manager.ui.mainCamera.transform.position - var_117_5.position).y, (manager.ui.mainCamera.transform.position - var_117_5.position).z)
				var_117_5.localEulerAngles.z = 0
				var_117_5.localEulerAngles.x = 0
				var_117_5.localEulerAngles = var_117_5.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_6 and arg_114_1.time_ < 0 + var_117_6 + arg_117_0 then
				var_117_5.localPosition = Vector3.New(0, -1.1, -5.6)
				var_117_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_5.position).x, (manager.ui.mainCamera.transform.position - var_117_5.position).y, (manager.ui.mainCamera.transform.position - var_117_5.position).z)
				var_117_5.localEulerAngles.z = 0
				var_117_5.localEulerAngles.x = 0
				var_117_5.localEulerAngles = var_117_5.localEulerAngles
			end

			local var_117_7 = arg_114_1.actors_["10004ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_7) and arg_114_1.var_.characterEffect10004ui_story == nil then
				arg_114_1.var_.characterEffect10004ui_story = var_117_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_8 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_8 and not isNil(var_117_7) then
				if arg_114_1.var_.characterEffect10004ui_story and not isNil(var_117_7) then
					arg_114_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_8 and arg_114_1.time_ < 0 + var_117_8 + arg_117_0 and not isNil(var_117_7) and arg_114_1.var_.characterEffect10004ui_story then
				arg_114_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action4_1")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_117_10 = 0
			local var_117_11 = 0.45

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_12 = arg_114_1:GetWordFromCfg(109061028)
				local var_117_13 = arg_114_1:FormatText(var_117_12.content)

				arg_114_1.text_.text = var_117_13

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_15 = 18 <= 0 and var_117_11 or var_117_11 * (utf8.len(var_117_13) / 18)

				if (18 <= 0 and var_117_11 or var_117_11 * (utf8.len(var_117_13) / 18)) > 0 and var_117_11 < var_117_15 then
					arg_114_1.talkMaxDuration = var_117_15

					if var_117_15 + var_117_10 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_15 + var_117_10
					end
				end

				arg_114_1.text_.text = var_117_13
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061028", "story_v_out_109061.awb") ~= 0 then
					local var_117_16 = manager.audio:GetVoiceLength("story_v_out_109061", "109061028", "story_v_out_109061.awb") / 1000

					if var_117_16 + var_117_10 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_16 + var_117_10
					end

					if var_117_12.prefab_name ~= "" and arg_114_1.actors_[var_117_12.prefab_name] ~= nil then
						local var_117_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_12.prefab_name].transform, "story_v_out_109061", "109061028", "story_v_out_109061.awb")

						arg_114_1:RecordAudio("109061028", var_117_17)
						arg_114_1:RecordAudio("109061028", var_117_17)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_109061", "109061028", "story_v_out_109061.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_109061", "109061028", "story_v_out_109061.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_18 = math.max(var_117_11, arg_114_1.talkMaxDuration)

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_18 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_10) / var_117_18

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_10 + var_117_18 and arg_114_1.time_ < var_117_10 + var_117_18 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play109061029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 109061029
		arg_118_1.duration_ = 6.1

		local var_118_0 = {
			ja = 6.066,
			ko = 5.6,
			zh = 4.833,
			en = 6.1
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
			arg_118_1.auto_ = false
		end

		function arg_118_1.playNext_(arg_120_0)
			arg_118_1.onStoryFinished_()
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = arg_118_1.actors_["1084ui_story"].transform.localPosition

				arg_118_1:ShowWeapon(arg_118_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).z)
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles = arg_118_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_118_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).z)
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles = arg_118_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_121_1 = arg_118_1.actors_["10004ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos10004ui_story = var_121_1.localPosition
			end

			local var_121_2 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 then
				var_121_1.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10004ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_2)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 then
				var_121_1.localPosition = Vector3.New(0, 100, 0)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles
			end

			local var_121_3 = arg_118_1.actors_["1050ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1050ui_story = var_121_3.localPosition

				arg_118_1:ShowWeapon(arg_118_1.var_["1050ui_story" .. "Animator"].transform, true)
			end

			local var_121_4 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				var_121_3.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_118_1.time_ - 0) / var_121_4)
				var_121_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_3.position).x, (manager.ui.mainCamera.transform.position - var_121_3.position).y, (manager.ui.mainCamera.transform.position - var_121_3.position).z)
				var_121_3.localEulerAngles.z = 0
				var_121_3.localEulerAngles.x = 0
				var_121_3.localEulerAngles = var_121_3.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				var_121_3.localPosition = Vector3.New(-0.7, -1, -6.1)
				var_121_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_3.position).x, (manager.ui.mainCamera.transform.position - var_121_3.position).y, (manager.ui.mainCamera.transform.position - var_121_3.position).z)
				var_121_3.localEulerAngles.z = 0
				var_121_3.localEulerAngles.x = 0
				var_121_3.localEulerAngles = var_121_3.localEulerAngles
			end

			local var_121_5 = arg_118_1.actors_["1084ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_5) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_6 and not isNil(var_121_5) then
				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_5) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_6 and arg_118_1.time_ < 0 + var_121_6 + arg_121_0 and not isNil(var_121_5) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_121_8 = 0
			local var_121_9 = 0.525

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_10 = arg_118_1:GetWordFromCfg(109061029)
				local var_121_11 = arg_118_1:FormatText(var_121_10.content)

				arg_118_1.text_.text = var_121_11

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_13 = 21 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_11) / 21)

				if (21 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_11) / 21)) > 0 and var_121_9 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_8
					end
				end

				arg_118_1.text_.text = var_121_11
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061029", "story_v_out_109061.awb") ~= 0 then
					local var_121_14 = manager.audio:GetVoiceLength("story_v_out_109061", "109061029", "story_v_out_109061.awb") / 1000

					if var_121_14 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_14 + var_121_8
					end

					if var_121_10.prefab_name ~= "" and arg_118_1.actors_[var_121_10.prefab_name] ~= nil then
						local var_121_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_10.prefab_name].transform, "story_v_out_109061", "109061029", "story_v_out_109061.awb")

						arg_118_1:RecordAudio("109061029", var_121_15)
						arg_118_1:RecordAudio("109061029", var_121_15)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_109061", "109061029", "story_v_out_109061.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_109061", "109061029", "story_v_out_109061.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_16 = math.max(var_121_9, arg_118_1.talkMaxDuration)

			if var_121_8 <= arg_118_1.time_ and arg_118_1.time_ < var_121_8 + var_121_16 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_8) / var_121_16

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_8 + var_121_16 and arg_118_1.time_ < var_121_8 + var_121_16 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C07_1"
	},
	voices = {
		"story_v_out_109061.awb"
	}
}

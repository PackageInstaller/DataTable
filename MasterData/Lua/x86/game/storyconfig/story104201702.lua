return {
	Play420172001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420172001
		arg_1_1.duration_ = 3.8

		local var_1_0 = {
			zh = 3.79999999702,
			ja = 3.800000000001
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
				arg_1_0:Play420172002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST67 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST67")
				var_4_0.name = "ST67"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST67 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST67

				arg_1_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST67" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.000000000001

			if 2.000000000001 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.0666666666666664 and arg_1_1.time_ < var_4_4 + 0.0666666666666664 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 1.00008890058234e-12

			if 1.00008890058234e-12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "1061ui_story"

			if arg_1_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1061ui_story"].transform

			if 1.79999999702077 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999999702077 + arg_4_0 then
				arg_1_1.var_.moveOldPos1061ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.79999999702077 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999999702077 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_1_1.time_ - 1.79999999702077) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.79999999702077 + var_4_14 and arg_1_1.time_ < 1.79999999702077 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.18, -6.15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1061ui_story"]

			if 1.79999999702077 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999999702077 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1061ui_story == nil then
				arg_1_1.var_.characterEffect1061ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.79999999702077 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999999702077 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1061ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.79999999702077 + var_4_16 and arg_1_1.time_ < 1.79999999702077 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1061ui_story then
				arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 1.79999999702077 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999999702077 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 1.79999999702077 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999999702077 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.05 < arg_1_1.time_ and arg_1_1.time_ <= 0.05 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2.000000000001
			local var_4_26 = 0.15

			if 2.000000000001 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(420172001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 6 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 6)

				if (6 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 6)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172001", "story_v_out_420172.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_420172", "420172001", "story_v_out_420172.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_420172", "420172001", "story_v_out_420172.awb")

						arg_1_1:RecordAudio("420172001", var_4_33)
						arg_1_1:RecordAudio("420172001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_420172", "420172001", "story_v_out_420172.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_420172", "420172001", "story_v_out_420172.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.79999999702077,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play420172002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 420172002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play420172003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1061ui_story = arg_9_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).z)
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles = arg_9_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).z)
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles = arg_9_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_12_1 = 0
			local var_12_2 = 0.35

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(420172002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 14 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 14)

				if (14 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 14)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play420172003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420172003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play420172004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0.05 < arg_13_1.time_ and arg_13_1.time_ <= 0.05 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_140", "se_story_140_camera04", "")
			end

			local var_16_1 = 0.1

			if 0.1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_2 = 0.15

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = Color.New(1, 1, 1)

				var_16_3.a = Mathf.Lerp(1, 0, (arg_13_1.time_ - var_16_1) / var_16_2)
				arg_13_1.mask_.color = var_16_3
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				local var_16_4 = Color.New(1, 1, 1)

				arg_13_1.mask_.enabled = false
				var_16_4.a = 0
				arg_13_1.mask_.color = var_16_4
			end

			local var_16_5 = 0
			local var_16_6 = 0.95

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(420172003).content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 38 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 38)

				if (38 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 38)) > 0 and var_16_6 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_10 and arg_13_1.time_ < var_16_5 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play420172004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 420172004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play420172005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.925

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(420172004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 37 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 37)

				if (37 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 37)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play420172005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 420172005
		arg_21_1.duration_ = 11.43

		local var_21_0 = {
			zh = 8.6,
			ja = 11.433
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play420172006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061ui_story = arg_21_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).z)
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles = arg_21_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_21_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).z)
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles = arg_21_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1061ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1061ui_story == nil then
				arg_21_1.var_.characterEffect1061ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1061ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1061ui_story then
				arg_21_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action6_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_24_4 = 0
			local var_24_5 = 0.9

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(420172005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 36 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 36)

				if (36 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 36)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172005", "story_v_out_420172.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_420172", "420172005", "story_v_out_420172.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_420172", "420172005", "story_v_out_420172.awb")

						arg_21_1:RecordAudio("420172005", var_24_11)
						arg_21_1:RecordAudio("420172005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_420172", "420172005", "story_v_out_420172.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_420172", "420172005", "story_v_out_420172.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play420172006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 420172006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play420172007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1061ui_story"]) and arg_25_1.var_.characterEffect1061ui_story == nil then
				arg_25_1.var_.characterEffect1061ui_story = arg_25_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1061ui_story"]) then
				if arg_25_1.var_.characterEffect1061ui_story and not isNil(arg_25_1.actors_["1061ui_story"]) then
					arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1061ui_story"]) and arg_25_1.var_.characterEffect1061ui_story then
				arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.575

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(420172006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 23 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 23)

				if (23 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 23)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play420172007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 420172007
		arg_29_1.duration_ = 6.1

		local var_29_0 = {
			zh = 5.1,
			ja = 6.1
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play420172008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1061ui_story"]) and arg_29_1.var_.characterEffect1061ui_story == nil then
				arg_29_1.var_.characterEffect1061ui_story = arg_29_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1061ui_story"]) then
				if arg_29_1.var_.characterEffect1061ui_story and not isNil(arg_29_1.actors_["1061ui_story"]) then
					arg_29_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1061ui_story"]) and arg_29_1.var_.characterEffect1061ui_story then
				arg_29_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action6_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_2 = 0
			local var_32_3 = 0.5

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(420172007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 20 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 20)

				if (20 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 20)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172007", "story_v_out_420172.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172007", "story_v_out_420172.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_420172", "420172007", "story_v_out_420172.awb")

						arg_29_1:RecordAudio("420172007", var_32_9)
						arg_29_1:RecordAudio("420172007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_420172", "420172007", "story_v_out_420172.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_420172", "420172007", "story_v_out_420172.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play420172008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 420172008
		arg_33_1.duration_ = 4.97

		local var_33_0 = {
			zh = 2.933,
			ja = 4.966
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play420172009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(420172008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 13 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 13)

				if (13 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 13)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172008", "story_v_out_420172.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_420172", "420172008", "story_v_out_420172.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_420172", "420172008", "story_v_out_420172.awb")

						arg_33_1:RecordAudio("420172008", var_36_6)
						arg_33_1:RecordAudio("420172008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_420172", "420172008", "story_v_out_420172.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_420172", "420172008", "story_v_out_420172.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play420172009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 420172009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play420172010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1061ui_story"]) and arg_37_1.var_.characterEffect1061ui_story == nil then
				arg_37_1.var_.characterEffect1061ui_story = arg_37_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1061ui_story"]) then
				if arg_37_1.var_.characterEffect1061ui_story and not isNil(arg_37_1.actors_["1061ui_story"]) then
					arg_37_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1061ui_story"]) and arg_37_1.var_.characterEffect1061ui_story then
				arg_37_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 1.275

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(420172009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 51 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 51)

				if (51 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 51)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play420172010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 420172010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play420172011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(420172010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 5 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 5)

				if (5 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 5)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play420172011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 420172011
		arg_45_1.duration_ = 1.17

		local var_45_0 = {
			zh = 1,
			ja = 1.166
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play420172012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1061ui_story"]) and arg_45_1.var_.characterEffect1061ui_story == nil then
				arg_45_1.var_.characterEffect1061ui_story = arg_45_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1061ui_story"]) then
				if arg_45_1.var_.characterEffect1061ui_story and not isNil(arg_45_1.actors_["1061ui_story"]) then
					arg_45_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1061ui_story"]) and arg_45_1.var_.characterEffect1061ui_story then
				arg_45_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_48_2 = 0
			local var_48_3 = 0.05

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(420172011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 2 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 2)

				if (2 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 2)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172011", "story_v_out_420172.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172011", "story_v_out_420172.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_420172", "420172011", "story_v_out_420172.awb")

						arg_45_1:RecordAudio("420172011", var_48_9)
						arg_45_1:RecordAudio("420172011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_420172", "420172011", "story_v_out_420172.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_420172", "420172011", "story_v_out_420172.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_10 and arg_45_1.time_ < var_48_2 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play420172012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 420172012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play420172013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1061ui_story"]) and arg_49_1.var_.characterEffect1061ui_story == nil then
				arg_49_1.var_.characterEffect1061ui_story = arg_49_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1061ui_story"]) then
				if arg_49_1.var_.characterEffect1061ui_story and not isNil(arg_49_1.actors_["1061ui_story"]) then
					arg_49_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1061ui_story"]) and arg_49_1.var_.characterEffect1061ui_story then
				arg_49_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(420172012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 24 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 24)

				if (24 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 24)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play420172013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 420172013
		arg_53_1.duration_ = 3.8

		local var_53_0 = {
			zh = 3.2,
			ja = 3.8
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play420172014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1061ui_story"]) and arg_53_1.var_.characterEffect1061ui_story == nil then
				arg_53_1.var_.characterEffect1061ui_story = arg_53_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1061ui_story"]) then
				if arg_53_1.var_.characterEffect1061ui_story and not isNil(arg_53_1.actors_["1061ui_story"]) then
					arg_53_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1061ui_story"]) and arg_53_1.var_.characterEffect1061ui_story then
				arg_53_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_2 = 0
			local var_56_3 = 0.325

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(420172013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 13 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 13)

				if (13 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 13)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172013", "story_v_out_420172.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172013", "story_v_out_420172.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_420172", "420172013", "story_v_out_420172.awb")

						arg_53_1:RecordAudio("420172013", var_56_9)
						arg_53_1:RecordAudio("420172013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_420172", "420172013", "story_v_out_420172.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_420172", "420172013", "story_v_out_420172.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play420172014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 420172014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play420172015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1061ui_story"]) and arg_57_1.var_.characterEffect1061ui_story == nil then
				arg_57_1.var_.characterEffect1061ui_story = arg_57_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1061ui_story"]) then
				if arg_57_1.var_.characterEffect1061ui_story and not isNil(arg_57_1.actors_["1061ui_story"]) then
					arg_57_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1061ui_story"]) and arg_57_1.var_.characterEffect1061ui_story then
				arg_57_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.2

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(420172014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 8 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 8)

				if (8 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 8)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play420172015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 420172015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play420172016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.35

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(420172015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 54 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 54)

				if (54 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 54)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play420172016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 420172016
		arg_65_1.duration_ = 4.93

		local var_65_0 = {
			zh = 4.4,
			ja = 4.933
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play420172017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1061ui_story"]) and arg_65_1.var_.characterEffect1061ui_story == nil then
				arg_65_1.var_.characterEffect1061ui_story = arg_65_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1061ui_story"]) then
				if arg_65_1.var_.characterEffect1061ui_story and not isNil(arg_65_1.actors_["1061ui_story"]) then
					arg_65_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1061ui_story"]) and arg_65_1.var_.characterEffect1061ui_story then
				arg_65_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_68_2 = 0
			local var_68_3 = 0.525

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(420172016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 21 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 21)

				if (21 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 21)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172016", "story_v_out_420172.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172016", "story_v_out_420172.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_420172", "420172016", "story_v_out_420172.awb")

						arg_65_1:RecordAudio("420172016", var_68_9)
						arg_65_1:RecordAudio("420172016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_420172", "420172016", "story_v_out_420172.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_420172", "420172016", "story_v_out_420172.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play420172017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 420172017
		arg_69_1.duration_ = 10.1

		local var_69_0 = {
			zh = 6.533,
			ja = 10.1
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play420172018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_72_0 = 0
			local var_72_1 = 0.775

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(420172017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 31 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 31)

				if (31 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 31)) > 0 and var_72_1 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172017", "story_v_out_420172.awb") ~= 0 then
					local var_72_6 = manager.audio:GetVoiceLength("story_v_out_420172", "420172017", "story_v_out_420172.awb") / 1000

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end

					if var_72_2.prefab_name ~= "" and arg_69_1.actors_[var_72_2.prefab_name] ~= nil then
						local var_72_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_2.prefab_name].transform, "story_v_out_420172", "420172017", "story_v_out_420172.awb")

						arg_69_1:RecordAudio("420172017", var_72_7)
						arg_69_1:RecordAudio("420172017", var_72_7)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_420172", "420172017", "story_v_out_420172.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_420172", "420172017", "story_v_out_420172.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play420172018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 420172018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play420172019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1061ui_story = arg_73_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1061ui_story"].transform.position).z)
				arg_73_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1061ui_story"].transform.localEulerAngles = arg_73_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1061ui_story"].transform.position).z)
				arg_73_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1061ui_story"].transform.localEulerAngles = arg_73_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_76_1 = 0
			local var_76_2 = 0.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(420172018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 8 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 8)

				if (8 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 8)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play420172019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 420172019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play420172020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.25

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(420172019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 10 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 10)

				if (10 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 10)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play420172020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 420172020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play420172021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.3

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(420172020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 52 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 52)

				if (52 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 52)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play420172021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 420172021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play420172022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(420172021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 16 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 16)

				if (16 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 16)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play420172022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 420172022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play420172023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.5

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(420172022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 20 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 20)

				if (20 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 20)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play420172023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 420172023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play420172024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.65

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(420172023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 26 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 26)

				if (26 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 26)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play420172024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 420172024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play420172025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.875

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(420172024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 35 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 35)

				if (35 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 35)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play420172025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 420172025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play420172026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.4

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(420172025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 56 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 56)

				if (56 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 56)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play420172026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 420172026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play420172027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.05

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(420172026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 42 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 42)

				if (42 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 42)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play420172027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 420172027
		arg_109_1.duration_ = 5.5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play420172028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = false

				arg_109_1:SetGaussion(false)
			end

			local var_112_0 = 0.5

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				local var_112_1 = Color.New(1, 1, 1)

				var_112_1.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.mask_.color = var_112_1
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				local var_112_2 = Color.New(1, 1, 1)

				arg_109_1.mask_.enabled = false
				var_112_2.a = 0
				arg_109_1.mask_.color = var_112_2
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_3 = 0.5
			local var_112_4 = 0.325

			if 0.5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_5 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_5:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_6 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(420172027).content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_8 = 13 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_6) / 13)

				if (13 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_6) / 13)) > 0 and var_112_4 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8
					var_112_3 = var_112_3 + 0.3

					if var_112_8 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = var_112_3 + 0.3
			local var_112_10 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_9 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_9) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_9 + var_112_10 and arg_109_1.time_ < var_112_9 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play420172028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 420172028
		arg_115_1.duration_ = 1

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play420172029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1061ui_story = arg_115_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1061ui_story"].transform.position).z)
				arg_115_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1061ui_story"].transform.localEulerAngles = arg_115_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_115_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1061ui_story"].transform.position).z)
				arg_115_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1061ui_story"].transform.localEulerAngles = arg_115_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1061ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1061ui_story == nil then
				arg_115_1.var_.characterEffect1061ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1061ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1061ui_story then
				arg_115_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_118_4 = 0
			local var_118_5 = 0.05

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(420172028)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 2 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 2)

				if (2 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 2)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172028", "story_v_out_420172.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_420172", "420172028", "story_v_out_420172.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_out_420172", "420172028", "story_v_out_420172.awb")

						arg_115_1:RecordAudio("420172028", var_118_11)
						arg_115_1:RecordAudio("420172028", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_420172", "420172028", "story_v_out_420172.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_420172", "420172028", "story_v_out_420172.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play420172029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 420172029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play420172030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1061ui_story"]) and arg_119_1.var_.characterEffect1061ui_story == nil then
				arg_119_1.var_.characterEffect1061ui_story = arg_119_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1061ui_story"]) then
				if arg_119_1.var_.characterEffect1061ui_story and not isNil(arg_119_1.actors_["1061ui_story"]) then
					arg_119_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1061ui_story"]) and arg_119_1.var_.characterEffect1061ui_story then
				arg_119_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_122_1 = 0
			local var_122_2 = 0.55

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(420172029).content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 22 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 22)

				if (22 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 22)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_6 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_6 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_6

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_6 and arg_119_1.time_ < var_122_1 + var_122_6 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play420172030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 420172030
		arg_123_1.duration_ = 2.87

		local var_123_0 = {
			zh = 2.1,
			ja = 2.866
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
				arg_123_0:Play420172031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1061ui_story"]) and arg_123_1.var_.characterEffect1061ui_story == nil then
				arg_123_1.var_.characterEffect1061ui_story = arg_123_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1061ui_story"]) then
				if arg_123_1.var_.characterEffect1061ui_story and not isNil(arg_123_1.actors_["1061ui_story"]) then
					arg_123_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1061ui_story"]) and arg_123_1.var_.characterEffect1061ui_story then
				arg_123_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_2 = 0
			local var_126_3 = 0.25

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:GetWordFromCfg(420172030)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 10 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 10)

				if (10 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 10)) > 0 and var_126_3 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172030", "story_v_out_420172.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172030", "story_v_out_420172.awb") / 1000

					if var_126_8 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_2
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_out_420172", "420172030", "story_v_out_420172.awb")

						arg_123_1:RecordAudio("420172030", var_126_9)
						arg_123_1:RecordAudio("420172030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_420172", "420172030", "story_v_out_420172.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_420172", "420172030", "story_v_out_420172.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_10 and arg_123_1.time_ < var_126_2 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play420172031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 420172031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play420172032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1061ui_story"]) and arg_127_1.var_.characterEffect1061ui_story == nil then
				arg_127_1.var_.characterEffect1061ui_story = arg_127_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1061ui_story"]) then
				if arg_127_1.var_.characterEffect1061ui_story and not isNil(arg_127_1.actors_["1061ui_story"]) then
					arg_127_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1061ui_story"]) and arg_127_1.var_.characterEffect1061ui_story then
				arg_127_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_130_1 = 0
			local var_130_2 = 0.5

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(420172031).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 20 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 20)

				if (20 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 20)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play420172032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 420172032
		arg_131_1.duration_ = 16.4

		local var_131_0 = {
			zh = 10.633,
			ja = 16.4
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
				arg_131_0:Play420172033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1061ui_story"]) and arg_131_1.var_.characterEffect1061ui_story == nil then
				arg_131_1.var_.characterEffect1061ui_story = arg_131_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1061ui_story"]) then
				if arg_131_1.var_.characterEffect1061ui_story and not isNil(arg_131_1.actors_["1061ui_story"]) then
					arg_131_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1061ui_story"]) and arg_131_1.var_.characterEffect1061ui_story then
				arg_131_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_134_2 = 0
			local var_134_3 = 1.25

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_4 = arg_131_1:GetWordFromCfg(420172032)
				local var_134_5 = arg_131_1:FormatText(var_134_4.content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 50 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 50)

				if (50 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 50)) > 0 and var_134_3 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172032", "story_v_out_420172.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172032", "story_v_out_420172.awb") / 1000

					if var_134_8 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_2
					end

					if var_134_4.prefab_name ~= "" and arg_131_1.actors_[var_134_4.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_4.prefab_name].transform, "story_v_out_420172", "420172032", "story_v_out_420172.awb")

						arg_131_1:RecordAudio("420172032", var_134_9)
						arg_131_1:RecordAudio("420172032", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_420172", "420172032", "story_v_out_420172.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_420172", "420172032", "story_v_out_420172.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_10 and arg_131_1.time_ < var_134_2 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play420172033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 420172033
		arg_135_1.duration_ = 3.4

		local var_135_0 = {
			zh = 2.9,
			ja = 3.4
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
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play420172034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.35

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:GetWordFromCfg(420172033)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 14 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 14)

				if (14 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 14)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172033", "story_v_out_420172.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_420172", "420172033", "story_v_out_420172.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_420172", "420172033", "story_v_out_420172.awb")

						arg_135_1:RecordAudio("420172033", var_138_6)
						arg_135_1:RecordAudio("420172033", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_420172", "420172033", "story_v_out_420172.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_420172", "420172033", "story_v_out_420172.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play420172034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 420172034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play420172035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1061ui_story"]) and arg_139_1.var_.characterEffect1061ui_story == nil then
				arg_139_1.var_.characterEffect1061ui_story = arg_139_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1061ui_story"]) then
				if arg_139_1.var_.characterEffect1061ui_story and not isNil(arg_139_1.actors_["1061ui_story"]) then
					arg_139_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1061ui_story"]) and arg_139_1.var_.characterEffect1061ui_story then
				arg_139_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.125

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(420172034).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 5 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 5)

				if (5 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 5)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play420172035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 420172035
		arg_143_1.duration_ = 6.37

		local var_143_0 = {
			zh = 4.566,
			ja = 6.366
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play420172036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1061ui_story"]) and arg_143_1.var_.characterEffect1061ui_story == nil then
				arg_143_1.var_.characterEffect1061ui_story = arg_143_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1061ui_story"]) then
				if arg_143_1.var_.characterEffect1061ui_story and not isNil(arg_143_1.actors_["1061ui_story"]) then
					arg_143_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1061ui_story"]) and arg_143_1.var_.characterEffect1061ui_story then
				arg_143_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_146_2 = 0
			local var_146_3 = 0.6

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(420172035)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 24 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 24)

				if (24 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 24)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172035", "story_v_out_420172.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172035", "story_v_out_420172.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_420172", "420172035", "story_v_out_420172.awb")

						arg_143_1:RecordAudio("420172035", var_146_9)
						arg_143_1:RecordAudio("420172035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_420172", "420172035", "story_v_out_420172.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_420172", "420172035", "story_v_out_420172.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play420172036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 420172036
		arg_147_1.duration_ = 7.33

		local var_147_0 = {
			zh = 6.166,
			ja = 7.333
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play420172037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 4 < arg_147_1.time_ and arg_147_1.time_ <= 4 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			if arg_147_1.time_ >= 4 + 0.3 and arg_147_1.time_ < 4 + 0.3 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			local var_150_0 = "ST10"

			if arg_147_1.bgs_.ST10 == nil then
				local var_150_1 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_150_0)
				var_150_1.name = var_150_0
				var_150_1.transform.parent = arg_147_1.stage_.transform
				var_150_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_[var_150_0] = var_150_1
			end

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= 2 + arg_150_0 then
				local var_150_2 = arg_147_1.bgs_.ST10

				arg_147_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_3 = var_150_2:GetComponent("SpriteRenderer")

				if var_150_3 and var_150_3.sprite then
					local var_150_4 = 2 * (var_150_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_2.transform.localScale = Vector3.New(var_150_4 / var_150_3.sprite.bounds.size.y < var_150_4 * manager.ui.mainCameraCom_.aspect / var_150_3.sprite.bounds.size.x and var_150_4 * manager.ui.mainCameraCom_.aspect / var_150_3.sprite.bounds.size.x or var_150_4 / var_150_3.sprite.bounds.size.y, var_150_4 / var_150_3.sprite.bounds.size.y < var_150_4 * manager.ui.mainCameraCom_.aspect / var_150_3.sprite.bounds.size.x and var_150_4 * manager.ui.mainCameraCom_.aspect / var_150_3.sprite.bounds.size.x or var_150_4 / var_150_3.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "ST10" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_5 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_6 = 2

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_6 then
				local var_150_7 = Color.New(0, 0, 0)

				var_150_7.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_5) / var_150_6)
				arg_147_1.mask_.color = var_150_7
			end

			if arg_147_1.time_ >= var_150_5 + var_150_6 and arg_147_1.time_ < var_150_5 + var_150_6 + arg_150_0 then
				local var_150_8 = Color.New(0, 0, 0)

				var_150_8.a = 1
				arg_147_1.mask_.color = var_150_8
			end

			local var_150_9 = 2

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_10 = 2

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_10 then
				local var_150_11 = Color.New(0, 0, 0)

				var_150_11.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_9) / var_150_10)
				arg_147_1.mask_.color = var_150_11
			end

			if arg_147_1.time_ >= var_150_9 + var_150_10 and arg_147_1.time_ < var_150_9 + var_150_10 + arg_150_0 then
				local var_150_12 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_12.a = 0
				arg_147_1.mask_.color = var_150_12
			end

			local var_150_13 = arg_147_1.actors_["1061ui_story"].transform

			if 1.96599999815226 < arg_147_1.time_ and arg_147_1.time_ <= 1.96599999815226 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061ui_story = var_150_13.localPosition
			end

			local var_150_14 = 0.001

			if 1.96599999815226 <= arg_147_1.time_ and arg_147_1.time_ < 1.96599999815226 + var_150_14 then
				var_150_13.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 1.96599999815226) / var_150_14)
				var_150_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_13.position).x, (manager.ui.mainCamera.transform.position - var_150_13.position).y, (manager.ui.mainCamera.transform.position - var_150_13.position).z)
				var_150_13.localEulerAngles.z = 0
				var_150_13.localEulerAngles.x = 0
				var_150_13.localEulerAngles = var_150_13.localEulerAngles
			end

			if arg_147_1.time_ >= 1.96599999815226 + var_150_14 and arg_147_1.time_ < 1.96599999815226 + var_150_14 + arg_150_0 then
				var_150_13.localPosition = Vector3.New(0, 100, 0)
				var_150_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_13.position).x, (manager.ui.mainCamera.transform.position - var_150_13.position).y, (manager.ui.mainCamera.transform.position - var_150_13.position).z)
				var_150_13.localEulerAngles.z = 0
				var_150_13.localEulerAngles.x = 0
				var_150_13.localEulerAngles = var_150_13.localEulerAngles
			end

			local var_150_15 = arg_147_1.actors_["1061ui_story"].transform

			if 3.8 < arg_147_1.time_ and arg_147_1.time_ <= 3.8 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061ui_story = var_150_15.localPosition
			end

			local var_150_16 = 0.001

			if 3.8 <= arg_147_1.time_ and arg_147_1.time_ < 3.8 + var_150_16 then
				var_150_15.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_147_1.time_ - 3.8) / var_150_16)
				var_150_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_15.position).x, (manager.ui.mainCamera.transform.position - var_150_15.position).y, (manager.ui.mainCamera.transform.position - var_150_15.position).z)
				var_150_15.localEulerAngles.z = 0
				var_150_15.localEulerAngles.x = 0
				var_150_15.localEulerAngles = var_150_15.localEulerAngles
			end

			if arg_147_1.time_ >= 3.8 + var_150_16 and arg_147_1.time_ < 3.8 + var_150_16 + arg_150_0 then
				var_150_15.localPosition = Vector3.New(0, -1.18, -6.15)
				var_150_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_15.position).x, (manager.ui.mainCamera.transform.position - var_150_15.position).y, (manager.ui.mainCamera.transform.position - var_150_15.position).z)
				var_150_15.localEulerAngles.z = 0
				var_150_15.localEulerAngles.x = 0
				var_150_15.localEulerAngles = var_150_15.localEulerAngles
			end

			local var_150_17 = arg_147_1.actors_["1061ui_story"]

			if 3.8 < arg_147_1.time_ and arg_147_1.time_ <= 3.8 + arg_150_0 and not isNil(var_150_17) and arg_147_1.var_.characterEffect1061ui_story == nil then
				arg_147_1.var_.characterEffect1061ui_story = var_150_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_18 = 0.200000002980232

			if 3.8 <= arg_147_1.time_ and arg_147_1.time_ < 3.8 + var_150_18 and not isNil(var_150_17) then
				if arg_147_1.var_.characterEffect1061ui_story and not isNil(var_150_17) then
					arg_147_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 3.8 + var_150_18 and arg_147_1.time_ < 3.8 + var_150_18 + arg_150_0 and not isNil(var_150_17) and arg_147_1.var_.characterEffect1061ui_story then
				arg_147_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 3.8 < arg_147_1.time_ and arg_147_1.time_ <= 3.8 + arg_150_0 then
				arg_147_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 3.8 < arg_147_1.time_ and arg_147_1.time_ <= 3.8 + arg_150_0 then
				arg_147_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_20 = 4
			local var_150_21 = 0.275

			if 4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_20 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_22 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_22:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_23 = arg_147_1:GetWordFromCfg(420172036)
				local var_150_24 = arg_147_1:FormatText(var_150_23.content)

				arg_147_1.text_.text = var_150_24

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_26 = 11 <= 0 and var_150_21 or var_150_21 * (utf8.len(var_150_24) / 11)

				if (11 <= 0 and var_150_21 or var_150_21 * (utf8.len(var_150_24) / 11)) > 0 and var_150_21 < var_150_26 then
					arg_147_1.talkMaxDuration = var_150_26
					var_150_20 = var_150_20 + 0.3

					if var_150_26 + var_150_20 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_26 + var_150_20
					end
				end

				arg_147_1.text_.text = var_150_24
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172036", "story_v_out_420172.awb") ~= 0 then
					local var_150_27 = manager.audio:GetVoiceLength("story_v_out_420172", "420172036", "story_v_out_420172.awb") / 1000

					if var_150_27 + var_150_20 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_27 + var_150_20
					end

					if var_150_23.prefab_name ~= "" and arg_147_1.actors_[var_150_23.prefab_name] ~= nil then
						local var_150_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_23.prefab_name].transform, "story_v_out_420172", "420172036", "story_v_out_420172.awb")

						arg_147_1:RecordAudio("420172036", var_150_28)
						arg_147_1:RecordAudio("420172036", var_150_28)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_420172", "420172036", "story_v_out_420172.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_420172", "420172036", "story_v_out_420172.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_29 = var_150_20 + 0.3
			local var_150_30 = math.max(var_150_21, arg_147_1.talkMaxDuration)

			if var_150_20 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_29 + var_150_30 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_29) / var_150_30

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_29 + var_150_30 and arg_147_1.time_ < var_150_29 + var_150_30 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play420172037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 420172037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play420172038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1061ui_story"]) and arg_153_1.var_.characterEffect1061ui_story == nil then
				arg_153_1.var_.characterEffect1061ui_story = arg_153_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1061ui_story"]) then
				if arg_153_1.var_.characterEffect1061ui_story and not isNil(arg_153_1.actors_["1061ui_story"]) then
					arg_153_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1061ui_story"]) and arg_153_1.var_.characterEffect1061ui_story then
				arg_153_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 1.525

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(420172037).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 61 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 61)

				if (61 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 61)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_6 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_6 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_6

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_6 and arg_153_1.time_ < var_156_1 + var_156_6 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play420172038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 420172038
		arg_157_1.duration_ = 4.13

		local var_157_0 = {
			zh = 2.1,
			ja = 4.133
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play420172039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1061ui_story = arg_157_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1061ui_story"].transform.position).z)
				arg_157_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1061ui_story"].transform.localEulerAngles = arg_157_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_157_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1061ui_story"].transform.position).z)
				arg_157_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1061ui_story"].transform.localEulerAngles = arg_157_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1061ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1061ui_story == nil then
				arg_157_1.var_.characterEffect1061ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1061ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1061ui_story then
				arg_157_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_160_4 = 0
			local var_160_5 = 0.25

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(420172038)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 10 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 10)

				if (10 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 10)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172038", "story_v_out_420172.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_420172", "420172038", "story_v_out_420172.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_420172", "420172038", "story_v_out_420172.awb")

						arg_157_1:RecordAudio("420172038", var_160_11)
						arg_157_1:RecordAudio("420172038", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_420172", "420172038", "story_v_out_420172.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_420172", "420172038", "story_v_out_420172.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play420172039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 420172039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play420172040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1061ui_story"]) and arg_161_1.var_.characterEffect1061ui_story == nil then
				arg_161_1.var_.characterEffect1061ui_story = arg_161_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1061ui_story"]) then
				if arg_161_1.var_.characterEffect1061ui_story and not isNil(arg_161_1.actors_["1061ui_story"]) then
					arg_161_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_0)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1061ui_story"]) and arg_161_1.var_.characterEffect1061ui_story then
				arg_161_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_164_1 = 0
			local var_164_2 = 0.3

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(420172039).content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 12 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 12)

				if (12 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 12)) > 0 and var_164_2 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_6 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_6 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_6

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_6 and arg_161_1.time_ < var_164_1 + var_164_6 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play420172040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 420172040
		arg_165_1.duration_ = 9.53

		local var_165_0 = {
			zh = 5,
			ja = 9.533
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play420172041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1061ui_story"]) and arg_165_1.var_.characterEffect1061ui_story == nil then
				arg_165_1.var_.characterEffect1061ui_story = arg_165_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1061ui_story"]) then
				if arg_165_1.var_.characterEffect1061ui_story and not isNil(arg_165_1.actors_["1061ui_story"]) then
					arg_165_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1061ui_story"]) and arg_165_1.var_.characterEffect1061ui_story then
				arg_165_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_168_2 = 0
			local var_168_3 = 0.65

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_4 = arg_165_1:GetWordFromCfg(420172040)
				local var_168_5 = arg_165_1:FormatText(var_168_4.content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_7 = 26 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 26)

				if (26 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 26)) > 0 and var_168_3 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_2
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172040", "story_v_out_420172.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172040", "story_v_out_420172.awb") / 1000

					if var_168_8 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_2
					end

					if var_168_4.prefab_name ~= "" and arg_165_1.actors_[var_168_4.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_4.prefab_name].transform, "story_v_out_420172", "420172040", "story_v_out_420172.awb")

						arg_165_1:RecordAudio("420172040", var_168_9)
						arg_165_1:RecordAudio("420172040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_420172", "420172040", "story_v_out_420172.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_420172", "420172040", "story_v_out_420172.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_3, arg_165_1.talkMaxDuration)

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_2) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_2 + var_168_10 and arg_165_1.time_ < var_168_2 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play420172041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 420172041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play420172042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1061ui_story = arg_169_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1061ui_story"].transform.position).z)
				arg_169_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1061ui_story"].transform.localEulerAngles = arg_169_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1061ui_story"].transform.position).z)
				arg_169_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1061ui_story"].transform.localEulerAngles = arg_169_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_172_1 = 0
			local var_172_2 = 1.025

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(420172041).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 41 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 41)

				if (41 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 41)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play420172042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 420172042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play420172043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0.05 < arg_173_1.time_ and arg_173_1.time_ <= 0.05 + arg_176_0 then
				arg_173_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_keyboard", "")
			end

			local var_176_1 = 0
			local var_176_2 = 0.875

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(420172042).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 35 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 35)

				if (35 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 35)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play420172043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 420172043
		arg_177_1.duration_ = 3.87

		local var_177_0 = {
			zh = 2.2,
			ja = 3.866
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play420172044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1061ui_story = arg_177_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1061ui_story"].transform.position).z)
				arg_177_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1061ui_story"].transform.localEulerAngles = arg_177_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_177_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1061ui_story"].transform.position).z)
				arg_177_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1061ui_story"].transform.localEulerAngles = arg_177_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1061ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1061ui_story == nil then
				arg_177_1.var_.characterEffect1061ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1061ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1061ui_story then
				arg_177_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_180_4 = 0
			local var_180_5 = 0.325

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(420172043)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 13 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 13)

				if (13 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 13)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172043", "story_v_out_420172.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_420172", "420172043", "story_v_out_420172.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_420172", "420172043", "story_v_out_420172.awb")

						arg_177_1:RecordAudio("420172043", var_180_11)
						arg_177_1:RecordAudio("420172043", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_420172", "420172043", "story_v_out_420172.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_420172", "420172043", "story_v_out_420172.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play420172044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 420172044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play420172045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1061ui_story = arg_181_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1061ui_story"].transform.position).z)
				arg_181_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1061ui_story"].transform.localEulerAngles = arg_181_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1061ui_story"].transform.position).z)
				arg_181_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1061ui_story"].transform.localEulerAngles = arg_181_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_184_1 = 0
			local var_184_2 = 0.975

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(420172044).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 39 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 39)

				if (39 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 39)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play420172045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 420172045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play420172046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(420172045).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 40 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 40)

				if (40 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 40)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play420172046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 420172046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play420172047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.225

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(420172046).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 9 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 9)

				if (9 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 9)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play420172047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 420172047
		arg_193_1.duration_ = 14.17

		local var_193_0 = {
			zh = 11.3,
			ja = 14.166
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play420172048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1061ui_story = arg_193_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1061ui_story"].transform.position).z)
				arg_193_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1061ui_story"].transform.localEulerAngles = arg_193_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_193_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1061ui_story"].transform.position).z)
				arg_193_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1061ui_story"].transform.localEulerAngles = arg_193_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1061ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1061ui_story == nil then
				arg_193_1.var_.characterEffect1061ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1061ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1061ui_story then
				arg_193_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_196_4 = 0
			local var_196_5 = 1.175

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(420172047)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 47 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 47)

				if (47 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 47)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172047", "story_v_out_420172.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_420172", "420172047", "story_v_out_420172.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_420172", "420172047", "story_v_out_420172.awb")

						arg_193_1:RecordAudio("420172047", var_196_11)
						arg_193_1:RecordAudio("420172047", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_420172", "420172047", "story_v_out_420172.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_420172", "420172047", "story_v_out_420172.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play420172048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 420172048
		arg_197_1.duration_ = 14.43

		local var_197_0 = {
			zh = 8.633,
			ja = 14.433
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play420172049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.975

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(420172048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 39 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 39)

				if (39 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 39)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172048", "story_v_out_420172.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_420172", "420172048", "story_v_out_420172.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_420172", "420172048", "story_v_out_420172.awb")

						arg_197_1:RecordAudio("420172048", var_200_6)
						arg_197_1:RecordAudio("420172048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_420172", "420172048", "story_v_out_420172.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_420172", "420172048", "story_v_out_420172.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play420172049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 420172049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play420172050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0.6 < arg_201_1.time_ and arg_201_1.time_ <= 0.6 + arg_204_0 then
				arg_201_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_datastream", "")
			end

			local var_204_1 = arg_201_1.actors_["1061ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1061ui_story = var_204_1.localPosition
			end

			local var_204_2 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 then
				var_204_1.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_2)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 then
				var_204_1.localPosition = Vector3.New(0, 100, 0)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			local var_204_3 = 0
			local var_204_4 = 0.9

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_3 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_5 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(420172049).content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 36 <= 0 and var_204_4 or var_204_4 * (utf8.len(var_204_5) / 36)

				if (36 <= 0 and var_204_4 or var_204_4 * (utf8.len(var_204_5) / 36)) > 0 and var_204_4 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_3 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_3
					end
				end

				arg_201_1.text_.text = var_204_5
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_4, arg_201_1.talkMaxDuration)

			if var_204_3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_3 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_3) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_3 + var_204_8 and arg_201_1.time_ < var_204_3 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play420172050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 420172050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play420172051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0.05 < arg_205_1.time_ and arg_205_1.time_ <= 0.05 + arg_208_0 then
				arg_205_1:AudioAction("play", "effect", "se_story_3", "se_story_3_data", "")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_208_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_205_1.bgmTxt_.text ~= var_208_3 and arg_205_1.bgmTxt_.text ~= "" then
						if arg_205_1.bgmTxt2_.text ~= "" then
							arg_205_1.bgmTxt_.text = arg_205_1.bgmTxt2_.text
						end

						arg_205_1.bgmTxt2_.text = var_208_3

						arg_205_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_205_1.bgmTxt_.text = var_208_3
						arg_205_1.bgmTxt2_.text = var_208_3
					end

					if arg_205_1.bgmTimer then
						arg_205_1.bgmTimer:Stop()

						arg_205_1.bgmTimer = nil
					end

					if arg_205_1.settingData.show_music_name == 1 then
						arg_205_1.musicController:SetSelectedState("show")
						arg_205_1.musicAnimator_:Play("open", 0, 0)

						if arg_205_1.settingData.music_time ~= 0 then
							arg_205_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_205_1.settingData.music_time), function()
								if arg_205_1 == nil or isNil(arg_205_1.bgmTxt_) then
									return
								end

								arg_205_1.musicController:SetSelectedState("hide")
								arg_205_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_208_4 = 0
			local var_208_5 = 1.2

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(420172050).content)

				arg_205_1.text_.text = var_208_6

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_8 = 48 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_6) / 48)

				if (48 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_6) / 48)) > 0 and var_208_5 < var_208_8 then
					arg_205_1.talkMaxDuration = var_208_8

					if var_208_8 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_6
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_9 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_9 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_9

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_9 and arg_205_1.time_ < var_208_4 + var_208_9 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play420172051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 420172051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play420172052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.1

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_1 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(420172051).content)

				arg_210_1.text_.text = var_213_1

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_3 = 4 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 4)

				if (4 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 4)) > 0 and var_213_0 < var_213_3 then
					arg_210_1.talkMaxDuration = var_213_3

					if var_213_3 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_3 + 0
					end
				end

				arg_210_1.text_.text = var_213_1
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_4 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_4

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play420172052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 420172052
		arg_214_1.duration_ = 6.13

		local var_214_0 = {
			zh = 5.566,
			ja = 6.133
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play420172053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1061ui_story = arg_214_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).z)
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles = arg_214_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_214_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).z)
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles = arg_214_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_217_1 = arg_214_1.actors_["1061ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1061ui_story == nil then
				arg_214_1.var_.characterEffect1061ui_story = var_217_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_2 and not isNil(var_217_1) then
				if arg_214_1.var_.characterEffect1061ui_story and not isNil(var_217_1) then
					arg_214_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_2 and arg_214_1.time_ < 0 + var_217_2 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1061ui_story then
				arg_214_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_217_4 = 0
			local var_217_5 = 0.45

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_6 = arg_214_1:GetWordFromCfg(420172052)
				local var_217_7 = arg_214_1:FormatText(var_217_6.content)

				arg_214_1.text_.text = var_217_7

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 18 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 18)

				if (18 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 18)) > 0 and var_217_5 < var_217_9 then
					arg_214_1.talkMaxDuration = var_217_9

					if var_217_9 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_7
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172052", "story_v_out_420172.awb") ~= 0 then
					local var_217_10 = manager.audio:GetVoiceLength("story_v_out_420172", "420172052", "story_v_out_420172.awb") / 1000

					if var_217_10 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_4
					end

					if var_217_6.prefab_name ~= "" and arg_214_1.actors_[var_217_6.prefab_name] ~= nil then
						local var_217_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_6.prefab_name].transform, "story_v_out_420172", "420172052", "story_v_out_420172.awb")

						arg_214_1:RecordAudio("420172052", var_217_11)
						arg_214_1:RecordAudio("420172052", var_217_11)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_420172", "420172052", "story_v_out_420172.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_420172", "420172052", "story_v_out_420172.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_12 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_12 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_12

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_12 and arg_214_1.time_ < var_217_4 + var_217_12 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play420172053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 420172053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play420172054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1061ui_story = arg_218_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1061ui_story"].transform.position).z)
				arg_218_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1061ui_story"].transform.localEulerAngles = arg_218_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1061ui_story"].transform.position).z)
				arg_218_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1061ui_story"].transform.localEulerAngles = arg_218_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_221_1 = 0
			local var_221_2 = 1.025

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_3 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(420172053).content)

				arg_218_1.text_.text = var_221_3

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 41 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 41)

				if (41 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 41)) > 0 and var_221_2 < var_221_5 then
					arg_218_1.talkMaxDuration = var_221_5

					if var_221_5 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + var_221_1
					end
				end

				arg_218_1.text_.text = var_221_3
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_6 = math.max(var_221_2, arg_218_1.talkMaxDuration)

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_6 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_1) / var_221_6

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_1 + var_221_6 and arg_218_1.time_ < var_221_1 + var_221_6 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play420172054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 420172054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play420172055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.65

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(420172054).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 26 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 26)

				if (26 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 26)) > 0 and var_225_0 < var_225_3 then
					arg_222_1.talkMaxDuration = var_225_3

					if var_225_3 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_3 + 0
					end
				end

				arg_222_1.text_.text = var_225_1
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_4 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_4

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play420172055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 420172055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play420172056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.2

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(420172055).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 8 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 8)

				if (8 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 8)) > 0 and var_229_0 < var_229_3 then
					arg_226_1.talkMaxDuration = var_229_3

					if var_229_3 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_3 + 0
					end
				end

				arg_226_1.text_.text = var_229_1
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_4 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_4

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play420172056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 420172056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play420172057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 1.025

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(420172056).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 41 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 41)

				if (41 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 41)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play420172057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 420172057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play420172058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 1.35

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_1 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(420172057).content)

				arg_234_1.text_.text = var_237_1

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_3 = 54 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 54)

				if (54 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 54)) > 0 and var_237_0 < var_237_3 then
					arg_234_1.talkMaxDuration = var_237_3

					if var_237_3 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_3 + 0
					end
				end

				arg_234_1.text_.text = var_237_1
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_4 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_4

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play420172058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 420172058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play420172059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.225

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(420172058).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 9 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 9)

				if (9 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 9)) > 0 and var_241_0 < var_241_3 then
					arg_238_1.talkMaxDuration = var_241_3

					if var_241_3 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_3 + 0
					end
				end

				arg_238_1.text_.text = var_241_1
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_4 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_4

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play420172059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 420172059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play420172060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 1.075

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(420172059).content)

				arg_242_1.text_.text = var_245_1

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_3 = 43 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 43)

				if (43 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 43)) > 0 and var_245_0 < var_245_3 then
					arg_242_1.talkMaxDuration = var_245_3

					if var_245_3 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_3 + 0
					end
				end

				arg_242_1.text_.text = var_245_1
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_4 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_4

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play420172060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 420172060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play420172061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 1.375

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(420172060).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 55 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 55)

				if (55 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 55)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play420172061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 420172061
		arg_250_1.duration_ = 15.27

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play420172062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if arg_250_1.bgs_.STwhite == nil then
				local var_253_0 = Object.Instantiate(arg_250_1.paintGo_)

				var_253_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_253_0.name = "STwhite"
				var_253_0.transform.parent = arg_250_1.stage_.transform
				var_253_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.bgs_.STwhite = var_253_0
			end

			if 2 < arg_250_1.time_ and arg_250_1.time_ <= 2 + arg_253_0 then
				local var_253_1 = arg_250_1.bgs_.STwhite

				arg_250_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_253_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_253_2 = var_253_1:GetComponent("SpriteRenderer")

				if var_253_2 and var_253_2.sprite then
					local var_253_3 = 2 * (var_253_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_253_1.transform.localScale = Vector3.New(var_253_3 / var_253_2.sprite.bounds.size.y < var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x and var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x or var_253_3 / var_253_2.sprite.bounds.size.y, var_253_3 / var_253_2.sprite.bounds.size.y < var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x and var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x or var_253_3 / var_253_2.sprite.bounds.size.y, 0)
				end

				for iter_253_0, iter_253_1 in pairs(arg_250_1.bgs_) do
					if iter_253_0 ~= "STwhite" then
						iter_253_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_253_4 = 0

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_5 = 2

			if var_253_4 <= arg_250_1.time_ and arg_250_1.time_ < var_253_4 + var_253_5 then
				local var_253_6 = Color.New(1, 1, 1)

				var_253_6.a = Mathf.Lerp(0, 1, (arg_250_1.time_ - var_253_4) / var_253_5)
				arg_250_1.mask_.color = var_253_6
			end

			if arg_250_1.time_ >= var_253_4 + var_253_5 and arg_250_1.time_ < var_253_4 + var_253_5 + arg_253_0 then
				local var_253_7 = Color.New(1, 1, 1)

				var_253_7.a = 1
				arg_250_1.mask_.color = var_253_7
			end

			local var_253_8 = 2

			if 2 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_9 = 2

			if var_253_8 <= arg_250_1.time_ and arg_250_1.time_ < var_253_8 + var_253_9 then
				local var_253_10 = Color.New(1, 1, 1)

				var_253_10.a = Mathf.Lerp(1, 0, (arg_250_1.time_ - var_253_8) / var_253_9)
				arg_250_1.mask_.color = var_253_10
			end

			if arg_250_1.time_ >= var_253_8 + var_253_9 and arg_250_1.time_ < var_253_8 + var_253_9 + arg_253_0 then
				local var_253_11 = Color.New(1, 1, 1)

				arg_250_1.mask_.enabled = false
				var_253_11.a = 0
				arg_250_1.mask_.color = var_253_11
			end

			if 2 < arg_250_1.time_ and arg_250_1.time_ <= 2 + arg_253_0 then
				arg_250_1.cswbg_:SetActive(true)

				local var_253_12 = arg_250_1.cswt_:GetComponent("RectTransform")

				arg_250_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_253_12.offsetMin = Vector2.New(0, 0)
				var_253_12.offsetMax = Vector2.New(0, 130)
				arg_250_1.cswt_.text = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(419152).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.cswt_)

				arg_250_1.cswt_.fontSize = 120
				arg_250_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_250_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_250_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 2 < arg_250_1.time_ and arg_250_1.time_ <= 2 + arg_253_0 then
				arg_250_1.fswbg_:SetActive(true)
				arg_250_1.dialog_:SetActive(false)

				arg_250_1.fswtw_.percent = 0
				arg_250_1.fswt_.text = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(420172061).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.fswt_)

				arg_250_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_250_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_250_1.fswtw_:SetDirty()

				arg_250_1.typewritterCharCountI18N = 0

				SetActive(arg_250_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_250_1:ShowNextGo(false)
			end

			local var_253_13 = 2.76666666666667

			if 2.76666666666667 < arg_250_1.time_ and arg_250_1.time_ <= var_253_13 + arg_253_0 then
				arg_250_1.var_.oldValueTypewriter = arg_250_1.fswtw_.percent

				SetActive(arg_250_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_250_1:ShowNextGo(false)
			end

			local var_253_14 = 32
			local var_253_15 = 1.23333333333333
			local var_253_16, var_253_17 = arg_250_1:GetPercentByPara(arg_250_1:FormatText(arg_250_1:GetWordFromCfg(420172061).content), 1)

			if var_253_13 < arg_250_1.time_ and arg_250_1.time_ <= var_253_13 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0

				local var_253_18 = var_253_14 <= 0 and var_253_15 or var_253_15 * ((var_253_17 - arg_250_1.typewritterCharCountI18N) / var_253_14)

				if (var_253_14 <= 0 and var_253_15 or var_253_15 * ((var_253_17 - arg_250_1.typewritterCharCountI18N) / var_253_14)) > 0 and var_253_15 < var_253_18 then
					arg_250_1.talkMaxDuration = var_253_18

					if var_253_18 + var_253_13 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_18 + var_253_13
					end
				end
			end

			local var_253_19 = math.max(1.23333333333333, arg_250_1.talkMaxDuration)

			if var_253_13 <= arg_250_1.time_ and arg_250_1.time_ < var_253_13 + var_253_19 then
				arg_250_1.fswtw_.percent = Mathf.Lerp(arg_250_1.var_.oldValueTypewriter, var_253_16, (arg_250_1.time_ - var_253_13) / var_253_19)
				arg_250_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_250_1.fswtw_:SetDirty()
			end

			if arg_250_1.time_ >= var_253_13 + var_253_19 and arg_250_1.time_ < var_253_13 + var_253_19 + arg_253_0 then
				arg_250_1.fswtw_.percent = var_253_16

				arg_250_1.fswtw_:SetDirty()
				arg_250_1:ShowNextGo(true)

				arg_250_1.typewritterCharCountI18N = var_253_17
			end

			if 2 < arg_250_1.time_ and arg_250_1.time_ <= 2 + arg_253_0 then
				local var_253_20 = arg_250_1.fswbg_.transform:Find("textbox/adapt/content") or arg_250_1.fswbg_.transform:Find("textbox/content")
				local var_253_21 = arg_250_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_253_22 = var_253_20:GetComponent("RectTransform")

				var_253_20:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_253_22.offsetMin = Vector2.New(0, -70)
				var_253_22.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_253_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_250_1.bgmTxt_.text ~= var_253_25 and arg_250_1.bgmTxt_.text ~= "" then
						if arg_250_1.bgmTxt2_.text ~= "" then
							arg_250_1.bgmTxt_.text = arg_250_1.bgmTxt2_.text
						end

						arg_250_1.bgmTxt2_.text = var_253_25

						arg_250_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_250_1.bgmTxt_.text = var_253_25
						arg_250_1.bgmTxt2_.text = var_253_25
					end

					if arg_250_1.bgmTimer then
						arg_250_1.bgmTimer:Stop()

						arg_250_1.bgmTimer = nil
					end

					if arg_250_1.settingData.show_music_name == 1 then
						arg_250_1.musicController:SetSelectedState("show")
						arg_250_1.musicAnimator_:Play("open", 0, 0)

						if arg_250_1.settingData.music_time ~= 0 then
							arg_250_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_250_1.settingData.music_time), function()
								if arg_250_1 == nil or isNil(arg_250_1.bgmTxt_) then
									return
								end

								arg_250_1.musicController:SetSelectedState("hide")
								arg_250_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.53333333333333 < arg_250_1.time_ and arg_250_1.time_ <= 1.53333333333333 + arg_253_0 then
				arg_250_1:AudioAction("play", "music", "bgm_activity_4_0_story_intro", "bgm_activity_4_0_story_intro", "bgm_activity_4_0_story_intro.awb")

				local var_253_28 = manager.audio:GetAudioName("bgm_activity_4_0_story_intro", "bgm_activity_4_0_story_intro")

				if "" ~= "" then
					if arg_250_1.bgmTxt_.text ~= var_253_28 and arg_250_1.bgmTxt_.text ~= "" then
						if arg_250_1.bgmTxt2_.text ~= "" then
							arg_250_1.bgmTxt_.text = arg_250_1.bgmTxt2_.text
						end

						arg_250_1.bgmTxt2_.text = var_253_28

						arg_250_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_250_1.bgmTxt_.text = var_253_28
						arg_250_1.bgmTxt2_.text = var_253_28
					end

					if arg_250_1.bgmTimer then
						arg_250_1.bgmTimer:Stop()

						arg_250_1.bgmTimer = nil
					end

					if arg_250_1.settingData.show_music_name == 1 then
						arg_250_1.musicController:SetSelectedState("show")
						arg_250_1.musicAnimator_:Play("open", 0, 0)

						if arg_250_1.settingData.music_time ~= 0 then
							arg_250_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_250_1.settingData.music_time), function()
								if arg_250_1 == nil or isNil(arg_250_1.bgmTxt_) then
									return
								end

								arg_250_1.musicController:SetSelectedState("hide")
								arg_250_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.05 < arg_250_1.time_ and arg_250_1.time_ <= 0.05 + arg_253_0 then
				arg_250_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_253_30 = 2.76666666666667
			local var_253_31 = manager.audio:GetVoiceLength("story_v_out_420172", "420172061", "story_v_out_420172.awb") / 1000

			if var_253_31 > 0 and 12.5 < var_253_31 and var_253_31 + var_253_30 > arg_250_1.duration_ then
				arg_250_1.duration_ = var_253_31 + var_253_30
			end

			if var_253_30 < arg_250_1.time_ and arg_250_1.time_ <= var_253_30 + arg_253_0 then
				arg_250_1:AudioAction("play", "voice", "story_v_out_420172", "420172061", "story_v_out_420172.awb")
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play420172062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 420172062
		arg_256_1.duration_ = 16.13

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play420172063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.cswbg_:SetActive(true)

				local var_259_0 = arg_256_1.cswt_:GetComponent("RectTransform")

				arg_256_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_259_0.offsetMin = Vector2.New(0, 130)
				var_259_0.offsetMax = Vector2.New(0, 0)
				arg_256_1.cswt_.text = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(419153).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.cswt_)

				arg_256_1.cswt_.fontSize = 120
				arg_256_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_256_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_256_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.fswbg_:SetActive(true)
				arg_256_1.dialog_:SetActive(false)

				arg_256_1.fswtw_.percent = 0
				arg_256_1.fswt_.text = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(420172062).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.fswt_)

				arg_256_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_256_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_256_1.fswtw_:SetDirty()

				arg_256_1.typewritterCharCountI18N = 0

				SetActive(arg_256_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_256_1:ShowNextGo(false)
			end

			local var_259_1 = 0.766666666666667

			if 0.766666666666667 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.var_.oldValueTypewriter = arg_256_1.fswtw_.percent

				SetActive(arg_256_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_256_1:ShowNextGo(false)
			end

			local var_259_2 = 35
			local var_259_3 = 2.33333333333333
			local var_259_4, var_259_5 = arg_256_1:GetPercentByPara(arg_256_1:FormatText(arg_256_1:GetWordFromCfg(420172062).content), 1)

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				local var_259_6 = var_259_2 <= 0 and var_259_3 or var_259_3 * ((var_259_5 - arg_256_1.typewritterCharCountI18N) / var_259_2)

				if (var_259_2 <= 0 and var_259_3 or var_259_3 * ((var_259_5 - arg_256_1.typewritterCharCountI18N) / var_259_2)) > 0 and var_259_3 < var_259_6 then
					arg_256_1.talkMaxDuration = var_259_6

					if var_259_6 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_6 + var_259_1
					end
				end
			end

			local var_259_7 = math.max(2.33333333333333, arg_256_1.talkMaxDuration)

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_7 then
				arg_256_1.fswtw_.percent = Mathf.Lerp(arg_256_1.var_.oldValueTypewriter, var_259_4, (arg_256_1.time_ - var_259_1) / var_259_7)
				arg_256_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_256_1.fswtw_:SetDirty()
			end

			if arg_256_1.time_ >= var_259_1 + var_259_7 and arg_256_1.time_ < var_259_1 + var_259_7 + arg_259_0 then
				arg_256_1.fswtw_.percent = var_259_4

				arg_256_1.fswtw_:SetDirty()
				arg_256_1:ShowNextGo(true)

				arg_256_1.typewritterCharCountI18N = var_259_5
			end

			local var_259_8 = 0.766666666666667
			local var_259_9 = manager.audio:GetVoiceLength("story_v_out_420172", "420172062", "story_v_out_420172.awb") / 1000

			if var_259_9 > 0 and 15.366 < var_259_9 and var_259_9 + var_259_8 > arg_256_1.duration_ then
				arg_256_1.duration_ = var_259_9 + var_259_8
			end

			if var_259_8 < arg_256_1.time_ and arg_256_1.time_ <= var_259_8 + arg_259_0 then
				arg_256_1:AudioAction("play", "voice", "story_v_out_420172", "420172062", "story_v_out_420172.awb")
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play420172063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 420172063
		arg_260_1.duration_ = 15.13

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play420172064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.cswbg_:SetActive(true)

				local var_263_0 = arg_260_1.cswt_:GetComponent("RectTransform")

				arg_260_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_263_0.offsetMin = Vector2.New(0, 130)
				var_263_0.offsetMax = Vector2.New(0, 0)
				arg_260_1.cswt_.text = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(419154).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.cswt_)

				arg_260_1.cswt_.fontSize = 120
				arg_260_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_260_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_260_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.fswbg_:SetActive(true)
				arg_260_1.dialog_:SetActive(false)

				arg_260_1.fswtw_.percent = 0
				arg_260_1.fswt_.text = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(420172063).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.fswt_)

				arg_260_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_260_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_260_1.fswtw_:SetDirty()

				arg_260_1.typewritterCharCountI18N = 0

				SetActive(arg_260_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_260_1:ShowNextGo(false)
			end

			local var_263_1 = 0.766666666666667

			if 0.766666666666667 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.var_.oldValueTypewriter = arg_260_1.fswtw_.percent

				SetActive(arg_260_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_260_1:ShowNextGo(false)
			end

			local var_263_2 = 42
			local var_263_3 = 2.8
			local var_263_4, var_263_5 = arg_260_1:GetPercentByPara(arg_260_1:FormatText(arg_260_1:GetWordFromCfg(420172063).content), 1)

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				local var_263_6 = var_263_2 <= 0 and var_263_3 or var_263_3 * ((var_263_5 - arg_260_1.typewritterCharCountI18N) / var_263_2)

				if (var_263_2 <= 0 and var_263_3 or var_263_3 * ((var_263_5 - arg_260_1.typewritterCharCountI18N) / var_263_2)) > 0 and var_263_3 < var_263_6 then
					arg_260_1.talkMaxDuration = var_263_6

					if var_263_6 + var_263_1 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_6 + var_263_1
					end
				end
			end

			local var_263_7 = math.max(2.8, arg_260_1.talkMaxDuration)

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_7 then
				arg_260_1.fswtw_.percent = Mathf.Lerp(arg_260_1.var_.oldValueTypewriter, var_263_4, (arg_260_1.time_ - var_263_1) / var_263_7)
				arg_260_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_260_1.fswtw_:SetDirty()
			end

			if arg_260_1.time_ >= var_263_1 + var_263_7 and arg_260_1.time_ < var_263_1 + var_263_7 + arg_263_0 then
				arg_260_1.fswtw_.percent = var_263_4

				arg_260_1.fswtw_:SetDirty()
				arg_260_1:ShowNextGo(true)

				arg_260_1.typewritterCharCountI18N = var_263_5
			end

			local var_263_8 = 0.766666666666667
			local var_263_9 = manager.audio:GetVoiceLength("story_v_out_420172", "420172063", "story_v_out_420172.awb") / 1000

			if var_263_9 > 0 and 14.366 < var_263_9 and var_263_9 + var_263_8 > arg_260_1.duration_ then
				arg_260_1.duration_ = var_263_9 + var_263_8
			end

			if var_263_8 < arg_260_1.time_ and arg_260_1.time_ <= var_263_8 + arg_263_0 then
				arg_260_1:AudioAction("play", "voice", "story_v_out_420172", "420172063", "story_v_out_420172.awb")
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play420172064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 420172064
		arg_264_1.duration_ = 11.23

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play420172065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 3 < arg_264_1.time_ and arg_264_1.time_ <= 3 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			if arg_264_1.time_ >= 3 + 0.3 and arg_264_1.time_ < 3 + 0.3 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			if 1 < arg_264_1.time_ and arg_264_1.time_ <= 1 + arg_267_0 then
				local var_267_0 = arg_264_1.bgs_.STwhite

				arg_264_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_267_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_267_1 = var_267_0:GetComponent("SpriteRenderer")

				if var_267_1 and var_267_1.sprite then
					local var_267_2 = 2 * (var_267_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_267_0.transform.localScale = Vector3.New(var_267_2 / var_267_1.sprite.bounds.size.y < var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x and var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x or var_267_2 / var_267_1.sprite.bounds.size.y, var_267_2 / var_267_1.sprite.bounds.size.y < var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x and var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x or var_267_2 / var_267_1.sprite.bounds.size.y, 0)
				end

				for iter_267_0, iter_267_1 in pairs(arg_264_1.bgs_) do
					if iter_267_0 ~= "STwhite" then
						iter_267_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_267_3 = 0

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_3 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_4 = 1

			if var_267_3 <= arg_264_1.time_ and arg_264_1.time_ < var_267_3 + var_267_4 then
				local var_267_5 = Color.New(0, 0, 0)

				var_267_5.a = Mathf.Lerp(0, 1, (arg_264_1.time_ - var_267_3) / var_267_4)
				arg_264_1.mask_.color = var_267_5
			end

			if arg_264_1.time_ >= var_267_3 + var_267_4 and arg_264_1.time_ < var_267_3 + var_267_4 + arg_267_0 then
				local var_267_6 = Color.New(0, 0, 0)

				var_267_6.a = 1
				arg_264_1.mask_.color = var_267_6
			end

			local var_267_7 = 1

			if 1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_7 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_8 = 2

			if var_267_7 <= arg_264_1.time_ and arg_264_1.time_ < var_267_7 + var_267_8 then
				local var_267_9 = Color.New(0, 0, 0)

				var_267_9.a = Mathf.Lerp(1, 0, (arg_264_1.time_ - var_267_7) / var_267_8)
				arg_264_1.mask_.color = var_267_9
			end

			if arg_264_1.time_ >= var_267_7 + var_267_8 and arg_264_1.time_ < var_267_7 + var_267_8 + arg_267_0 then
				local var_267_10 = Color.New(0, 0, 0)

				arg_264_1.mask_.enabled = false
				var_267_10.a = 0
				arg_264_1.mask_.color = var_267_10
			end

			if 0.8 < arg_264_1.time_ and arg_264_1.time_ <= 0.8 + arg_267_0 then
				arg_264_1.cswbg_:SetActive(false)
			end

			if 0.866666666666667 < arg_264_1.time_ and arg_264_1.time_ <= 0.866666666666667 + arg_267_0 then
				arg_264_1.fswbg_:SetActive(false)
				arg_264_1.dialog_:SetActive(false)
				SetActive(arg_264_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_264_1:ShowNextGo(false)
			end

			if 1 < arg_264_1.time_ and arg_264_1.time_ <= 1 + arg_267_0 then
				arg_264_1.fswbg_:SetActive(true)
				arg_264_1.dialog_:SetActive(false)

				arg_264_1.fswtw_.percent = 0
				arg_264_1.fswt_.text = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(420172064).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.fswt_)

				arg_264_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_264_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_264_1.fswtw_:SetDirty()

				arg_264_1.typewritterCharCountI18N = 0

				SetActive(arg_264_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_264_1:ShowNextGo(false)
			end

			local var_267_11 = 2.03333333333333

			if 2.03333333333333 < arg_264_1.time_ and arg_264_1.time_ <= var_267_11 + arg_267_0 then
				arg_264_1.var_.oldValueTypewriter = arg_264_1.fswtw_.percent

				SetActive(arg_264_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_264_1:ShowNextGo(false)
			end

			local var_267_12 = 25
			local var_267_13 = 1.66666666666667
			local var_267_14, var_267_15 = arg_264_1:GetPercentByPara(arg_264_1:FormatText(arg_264_1:GetWordFromCfg(420172064).content), 1)

			if var_267_11 < arg_264_1.time_ and arg_264_1.time_ <= var_267_11 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				local var_267_16 = var_267_12 <= 0 and var_267_13 or var_267_13 * ((var_267_15 - arg_264_1.typewritterCharCountI18N) / var_267_12)

				if (var_267_12 <= 0 and var_267_13 or var_267_13 * ((var_267_15 - arg_264_1.typewritterCharCountI18N) / var_267_12)) > 0 and var_267_13 < var_267_16 then
					arg_264_1.talkMaxDuration = var_267_16

					if var_267_16 + var_267_11 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_16 + var_267_11
					end
				end
			end

			local var_267_17 = math.max(1.66666666666667, arg_264_1.talkMaxDuration)

			if var_267_11 <= arg_264_1.time_ and arg_264_1.time_ < var_267_11 + var_267_17 then
				arg_264_1.fswtw_.percent = Mathf.Lerp(arg_264_1.var_.oldValueTypewriter, var_267_14, (arg_264_1.time_ - var_267_11) / var_267_17)
				arg_264_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_264_1.fswtw_:SetDirty()
			end

			if arg_264_1.time_ >= var_267_11 + var_267_17 and arg_264_1.time_ < var_267_11 + var_267_17 + arg_267_0 then
				arg_264_1.fswtw_.percent = var_267_14

				arg_264_1.fswtw_:SetDirty()
				arg_264_1:ShowNextGo(true)

				arg_264_1.typewritterCharCountI18N = var_267_15
			end

			if 1 < arg_264_1.time_ and arg_264_1.time_ <= 1 + arg_267_0 then
				local var_267_18 = arg_264_1.fswbg_.transform:Find("textbox/adapt/content") or arg_264_1.fswbg_.transform:Find("textbox/content")
				local var_267_19 = arg_264_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_267_20 = var_267_18:GetComponent("RectTransform")

				var_267_18:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_267_20.offsetMin = Vector2.New(0, -70)
				var_267_20.offsetMax = Vector2.New(0, 0)
			end

			local var_267_21 = 2.03333333333333
			local var_267_22 = manager.audio:GetVoiceLength("story_v_out_420172", "420172064", "story_v_out_420172.awb") / 1000

			if var_267_22 > 0 and 9.2 < var_267_22 and var_267_22 + var_267_21 > arg_264_1.duration_ then
				arg_264_1.duration_ = var_267_22 + var_267_21
			end

			if var_267_21 < arg_264_1.time_ and arg_264_1.time_ <= var_267_21 + arg_267_0 then
				arg_264_1:AudioAction("play", "voice", "story_v_out_420172", "420172064", "story_v_out_420172.awb")
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play420172065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 420172065
		arg_268_1.duration_ = 1.73

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play420172066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.fswbg_:SetActive(true)
				arg_268_1.dialog_:SetActive(false)

				arg_268_1.fswtw_.percent = 0
				arg_268_1.fswt_.text = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(420172065).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.fswt_)

				arg_268_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_268_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_268_1.fswtw_:SetDirty()

				arg_268_1.typewritterCharCountI18N = 0

				SetActive(arg_268_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_268_1:ShowNextGo(false)
			end

			local var_271_0 = 0.133333333333333

			if 0.133333333333333 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.var_.oldValueTypewriter = arg_268_1.fswtw_.percent

				SetActive(arg_268_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_268_1:ShowNextGo(false)
			end

			local var_271_1 = 4
			local var_271_2 = 0.266666666666667
			local var_271_3, var_271_4 = arg_268_1:GetPercentByPara(arg_268_1:FormatText(arg_268_1:GetWordFromCfg(420172065).content), 1)

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0

				local var_271_5 = var_271_1 <= 0 and var_271_2 or var_271_2 * ((var_271_4 - arg_268_1.typewritterCharCountI18N) / var_271_1)

				if (var_271_1 <= 0 and var_271_2 or var_271_2 * ((var_271_4 - arg_268_1.typewritterCharCountI18N) / var_271_1)) > 0 and var_271_2 < var_271_5 then
					arg_268_1.talkMaxDuration = var_271_5

					if var_271_5 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + var_271_0
					end
				end
			end

			local var_271_6 = math.max(0.266666666666667, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_6 then
				arg_268_1.fswtw_.percent = Mathf.Lerp(arg_268_1.var_.oldValueTypewriter, var_271_3, (arg_268_1.time_ - var_271_0) / var_271_6)
				arg_268_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_268_1.fswtw_:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_6 and arg_268_1.time_ < var_271_0 + var_271_6 + arg_271_0 then
				arg_268_1.fswtw_.percent = var_271_3

				arg_268_1.fswtw_:SetDirty()
				arg_268_1:ShowNextGo(true)

				arg_268_1.typewritterCharCountI18N = var_271_4
			end

			local var_271_7 = 0.133333333333333
			local var_271_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172065", "story_v_out_420172.awb") / 1000

			if var_271_8 > 0 and 1.6 < var_271_8 and var_271_8 + var_271_7 > arg_268_1.duration_ then
				arg_268_1.duration_ = var_271_8 + var_271_7
			end

			if var_271_7 < arg_268_1.time_ and arg_268_1.time_ <= var_271_7 + arg_271_0 then
				arg_268_1:AudioAction("play", "voice", "story_v_out_420172", "420172065", "story_v_out_420172.awb")
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play420172066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 420172066
		arg_272_1.duration_ = 13.23

		local var_272_0 = {
			zh = 10,
			ja = 13.233
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play420172067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 2 < arg_272_1.time_ and arg_272_1.time_ <= 2 + arg_275_0 then
				local var_275_0 = arg_272_1.bgs_.ST67

				arg_272_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_275_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_275_1 = var_275_0:GetComponent("SpriteRenderer")

				if var_275_1 and var_275_1.sprite then
					local var_275_2 = 2 * (var_275_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_275_0.transform.localScale = Vector3.New(var_275_2 / var_275_1.sprite.bounds.size.y < var_275_2 * manager.ui.mainCameraCom_.aspect / var_275_1.sprite.bounds.size.x and var_275_2 * manager.ui.mainCameraCom_.aspect / var_275_1.sprite.bounds.size.x or var_275_2 / var_275_1.sprite.bounds.size.y, var_275_2 / var_275_1.sprite.bounds.size.y < var_275_2 * manager.ui.mainCameraCom_.aspect / var_275_1.sprite.bounds.size.x and var_275_2 * manager.ui.mainCameraCom_.aspect / var_275_1.sprite.bounds.size.x or var_275_2 / var_275_1.sprite.bounds.size.y, 0)
				end

				for iter_275_0, iter_275_1 in pairs(arg_272_1.bgs_) do
					if iter_275_0 ~= "ST67" then
						iter_275_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_275_3 = 4

			if 4 < arg_272_1.time_ and arg_272_1.time_ <= var_275_3 + arg_275_0 then
				arg_272_1.allBtn_.enabled = false
			end

			if arg_272_1.time_ >= var_275_3 + 0.3 and arg_272_1.time_ < var_275_3 + 0.3 + arg_275_0 then
				arg_272_1.allBtn_.enabled = true
			end

			local var_275_4 = 0

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1.mask_.enabled = true
				arg_272_1.mask_.raycastTarget = true

				arg_272_1:SetGaussion(false)
			end

			local var_275_5 = 2

			if var_275_4 <= arg_272_1.time_ and arg_272_1.time_ < var_275_4 + var_275_5 then
				local var_275_6 = Color.New(0, 0, 0)

				var_275_6.a = Mathf.Lerp(0, 1, (arg_272_1.time_ - var_275_4) / var_275_5)
				arg_272_1.mask_.color = var_275_6
			end

			if arg_272_1.time_ >= var_275_4 + var_275_5 and arg_272_1.time_ < var_275_4 + var_275_5 + arg_275_0 then
				local var_275_7 = Color.New(0, 0, 0)

				var_275_7.a = 1
				arg_272_1.mask_.color = var_275_7
			end

			local var_275_8 = 2

			if 2 < arg_272_1.time_ and arg_272_1.time_ <= var_275_8 + arg_275_0 then
				arg_272_1.mask_.enabled = true
				arg_272_1.mask_.raycastTarget = true

				arg_272_1:SetGaussion(false)
			end

			local var_275_9 = 2

			if var_275_8 <= arg_272_1.time_ and arg_272_1.time_ < var_275_8 + var_275_9 then
				local var_275_10 = Color.New(0, 0, 0)

				var_275_10.a = Mathf.Lerp(1, 0, (arg_272_1.time_ - var_275_8) / var_275_9)
				arg_272_1.mask_.color = var_275_10
			end

			if arg_272_1.time_ >= var_275_8 + var_275_9 and arg_272_1.time_ < var_275_8 + var_275_9 + arg_275_0 then
				local var_275_11 = Color.New(0, 0, 0)

				arg_272_1.mask_.enabled = false
				var_275_11.a = 0
				arg_272_1.mask_.color = var_275_11
			end

			if 1.86666666666667 < arg_272_1.time_ and arg_272_1.time_ <= 1.86666666666667 + arg_275_0 then
				arg_272_1.fswbg_:SetActive(false)
				arg_272_1.dialog_:SetActive(false)
				SetActive(arg_272_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_272_1:ShowNextGo(false)
			end

			local var_275_12 = 2

			arg_272_1.isInRecall_ = false

			if var_275_12 < arg_272_1.time_ and arg_272_1.time_ <= var_275_12 + arg_275_0 then
				arg_272_1.screenFilterGo_:SetActive(true)

				arg_272_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_275_2, iter_275_3 in pairs(arg_272_1.actors_) do
					for iter_275_4, iter_275_5 in ipairs((iter_275_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_275_5.color = iter_275_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_275_13 = 0.3

			if var_275_12 <= arg_272_1.time_ and arg_272_1.time_ < var_275_12 + var_275_13 then
				arg_272_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_272_1.time_ - var_275_12) / var_275_13)
			end

			if arg_272_1.time_ >= var_275_12 + var_275_13 and arg_272_1.time_ < var_275_12 + var_275_13 + arg_275_0 then
				arg_272_1.screenFilterEffect_.weight = 1
			end

			local var_275_14 = "1085ui_story"

			if arg_272_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_275_15 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_272_1.stage_.transform)

				var_275_15.name = var_275_14
				var_275_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_272_1.actors_[var_275_14] = var_275_15

				local var_275_16 = var_275_15:GetComponentInChildren(typeof(CharacterEffect))

				var_275_16.enabled = true

				local var_275_17 = GameObjectTools.GetOrAddComponent(var_275_15, typeof(DynamicBoneHelper))

				if var_275_17 then
					var_275_17:EnableDynamicBone(false)
				end

				arg_272_1:ShowWeapon(var_275_16.transform, false)

				arg_272_1.var_[var_275_14 .. "Animator"] = var_275_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_272_1.var_[var_275_14 .. "Animator"].applyRootMotion = true
				arg_272_1.var_[var_275_14 .. "LipSync"] = var_275_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_275_18 = arg_272_1.actors_["1085ui_story"].transform

			if 3.83333333333333 < arg_272_1.time_ and arg_272_1.time_ <= 3.83333333333333 + arg_275_0 then
				arg_272_1.var_.moveOldPos1085ui_story = var_275_18.localPosition
			end

			local var_275_19 = 0.001

			if 3.83333333333333 <= arg_272_1.time_ and arg_272_1.time_ < 3.83333333333333 + var_275_19 then
				var_275_18.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_272_1.time_ - 3.83333333333333) / var_275_19)
				var_275_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_275_18.position).x, (manager.ui.mainCamera.transform.position - var_275_18.position).y, (manager.ui.mainCamera.transform.position - var_275_18.position).z)
				var_275_18.localEulerAngles.z = 0
				var_275_18.localEulerAngles.x = 0
				var_275_18.localEulerAngles = var_275_18.localEulerAngles
			end

			if arg_272_1.time_ >= 3.83333333333333 + var_275_19 and arg_272_1.time_ < 3.83333333333333 + var_275_19 + arg_275_0 then
				var_275_18.localPosition = Vector3.New(0, -1.01, -5.83)
				var_275_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_275_18.position).x, (manager.ui.mainCamera.transform.position - var_275_18.position).y, (manager.ui.mainCamera.transform.position - var_275_18.position).z)
				var_275_18.localEulerAngles.z = 0
				var_275_18.localEulerAngles.x = 0
				var_275_18.localEulerAngles = var_275_18.localEulerAngles
			end

			local var_275_20 = arg_272_1.actors_["1085ui_story"]

			if 3.83333333333333 < arg_272_1.time_ and arg_272_1.time_ <= 3.83333333333333 + arg_275_0 and not isNil(var_275_20) and arg_272_1.var_.characterEffect1085ui_story == nil then
				arg_272_1.var_.characterEffect1085ui_story = var_275_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_21 = 0.200000002980232

			if 3.83333333333333 <= arg_272_1.time_ and arg_272_1.time_ < 3.83333333333333 + var_275_21 and not isNil(var_275_20) then
				if arg_272_1.var_.characterEffect1085ui_story and not isNil(var_275_20) then
					arg_272_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 3.83333333333333 + var_275_21 and arg_272_1.time_ < 3.83333333333333 + var_275_21 + arg_275_0 and not isNil(var_275_20) and arg_272_1.var_.characterEffect1085ui_story then
				arg_272_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_272_1.time_ and arg_272_1.time_ <= 3.83333333333333 + arg_275_0 then
				arg_272_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 3.83333333333333 < arg_272_1.time_ and arg_272_1.time_ <= 3.83333333333333 + arg_275_0 then
				arg_272_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if arg_272_1.frameCnt_ <= 1 then
				arg_272_1.dialog_:SetActive(false)
			end

			local var_275_23 = 4
			local var_275_24 = 0.45

			if 4 < arg_272_1.time_ and arg_272_1.time_ <= var_275_23 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0

				arg_272_1.dialog_:SetActive(true)

				arg_272_1.dialogCg_.alpha = 0

				local var_275_25 = LeanTween.value(arg_272_1.dialog_, 0, 1, 0.3)

				var_275_25:setOnUpdate(LuaHelper.FloatAction(function(arg_276_0)
					arg_272_1.dialogCg_.alpha = arg_276_0
				end))
				var_275_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_272_1.dialog_)
					var_275_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_272_1.duration_ = arg_272_1.duration_ + 0.3

				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_26 = arg_272_1:GetWordFromCfg(420172066)
				local var_275_27 = arg_272_1:FormatText(var_275_26.content)

				arg_272_1.text_.text = var_275_27

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_29 = 18 <= 0 and var_275_24 or var_275_24 * (utf8.len(var_275_27) / 18)

				if (18 <= 0 and var_275_24 or var_275_24 * (utf8.len(var_275_27) / 18)) > 0 and var_275_24 < var_275_29 then
					arg_272_1.talkMaxDuration = var_275_29
					var_275_23 = var_275_23 + 0.3

					if var_275_29 + var_275_23 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_29 + var_275_23
					end
				end

				arg_272_1.text_.text = var_275_27
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172066", "story_v_out_420172.awb") ~= 0 then
					local var_275_30 = manager.audio:GetVoiceLength("story_v_out_420172", "420172066", "story_v_out_420172.awb") / 1000

					if var_275_30 + var_275_23 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_30 + var_275_23
					end

					if var_275_26.prefab_name ~= "" and arg_272_1.actors_[var_275_26.prefab_name] ~= nil then
						local var_275_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_26.prefab_name].transform, "story_v_out_420172", "420172066", "story_v_out_420172.awb")

						arg_272_1:RecordAudio("420172066", var_275_31)
						arg_272_1:RecordAudio("420172066", var_275_31)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_420172", "420172066", "story_v_out_420172.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_420172", "420172066", "story_v_out_420172.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_32 = var_275_23 + 0.3
			local var_275_33 = math.max(var_275_24, arg_272_1.talkMaxDuration)

			if var_275_23 + 0.3 <= arg_272_1.time_ and arg_272_1.time_ < var_275_32 + var_275_33 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_32) / var_275_33

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_32 + var_275_33 and arg_272_1.time_ < var_275_32 + var_275_33 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play420172067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 420172067
		arg_278_1.duration_ = 19.43

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play420172068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				local var_281_0 = arg_278_1.bgs_.STwhite

				arg_278_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_281_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_1 = var_281_0:GetComponent("SpriteRenderer")

				if var_281_1 and var_281_1.sprite then
					local var_281_2 = 2 * (var_281_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_281_0.transform.localScale = Vector3.New(var_281_2 / var_281_1.sprite.bounds.size.y < var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x and var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x or var_281_2 / var_281_1.sprite.bounds.size.y, var_281_2 / var_281_1.sprite.bounds.size.y < var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x and var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x or var_281_2 / var_281_1.sprite.bounds.size.y, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "STwhite" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_281_3 = 0

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_3 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_4 = 2

			if var_281_3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_3 + var_281_4 then
				local var_281_5 = Color.New(0, 0, 0)

				var_281_5.a = Mathf.Lerp(0, 1, (arg_278_1.time_ - var_281_3) / var_281_4)
				arg_278_1.mask_.color = var_281_5
			end

			if arg_278_1.time_ >= var_281_3 + var_281_4 and arg_278_1.time_ < var_281_3 + var_281_4 + arg_281_0 then
				local var_281_6 = Color.New(0, 0, 0)

				var_281_6.a = 1
				arg_278_1.mask_.color = var_281_6
			end

			local var_281_7 = 2

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_7 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_8 = 2

			if var_281_7 <= arg_278_1.time_ and arg_278_1.time_ < var_281_7 + var_281_8 then
				local var_281_9 = Color.New(0, 0, 0)

				var_281_9.a = Mathf.Lerp(1, 0, (arg_278_1.time_ - var_281_7) / var_281_8)
				arg_278_1.mask_.color = var_281_9
			end

			if arg_278_1.time_ >= var_281_7 + var_281_8 and arg_278_1.time_ < var_281_7 + var_281_8 + arg_281_0 then
				local var_281_10 = Color.New(0, 0, 0)

				arg_278_1.mask_.enabled = false
				var_281_10.a = 0
				arg_278_1.mask_.color = var_281_10
			end

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				arg_278_1.cswbg_:SetActive(true)

				local var_281_11 = arg_278_1.cswt_:GetComponent("RectTransform")

				arg_278_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_281_11.offsetMin = Vector2.New(0, 0)
				var_281_11.offsetMax = Vector2.New(0, 130)
				arg_278_1.cswt_.text = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(419155).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.cswt_)

				arg_278_1.cswt_.fontSize = 120
				arg_278_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_278_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_278_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				arg_278_1.fswbg_:SetActive(true)
				arg_278_1.dialog_:SetActive(false)

				arg_278_1.fswtw_.percent = 0
				arg_278_1.fswt_.text = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(420172067).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.fswt_)

				arg_278_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_278_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_278_1.fswtw_:SetDirty()

				arg_278_1.typewritterCharCountI18N = 0

				SetActive(arg_278_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_278_1:ShowNextGo(false)
			end

			local var_281_12 = 3.23333333333333

			if 3.23333333333333 < arg_278_1.time_ and arg_278_1.time_ <= var_281_12 + arg_281_0 then
				arg_278_1.var_.oldValueTypewriter = arg_278_1.fswtw_.percent

				SetActive(arg_278_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_278_1:ShowNextGo(false)
			end

			local var_281_13 = 38
			local var_281_14 = 2.53333333333333
			local var_281_15, var_281_16 = arg_278_1:GetPercentByPara(arg_278_1:FormatText(arg_278_1:GetWordFromCfg(420172067).content), 1)

			if var_281_12 < arg_278_1.time_ and arg_278_1.time_ <= var_281_12 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				local var_281_17 = var_281_13 <= 0 and var_281_14 or var_281_14 * ((var_281_16 - arg_278_1.typewritterCharCountI18N) / var_281_13)

				if (var_281_13 <= 0 and var_281_14 or var_281_14 * ((var_281_16 - arg_278_1.typewritterCharCountI18N) / var_281_13)) > 0 and var_281_14 < var_281_17 then
					arg_278_1.talkMaxDuration = var_281_17

					if var_281_17 + var_281_12 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_17 + var_281_12
					end
				end
			end

			local var_281_18 = math.max(2.53333333333333, arg_278_1.talkMaxDuration)

			if var_281_12 <= arg_278_1.time_ and arg_278_1.time_ < var_281_12 + var_281_18 then
				arg_278_1.fswtw_.percent = Mathf.Lerp(arg_278_1.var_.oldValueTypewriter, var_281_15, (arg_278_1.time_ - var_281_12) / var_281_18)
				arg_278_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_278_1.fswtw_:SetDirty()
			end

			if arg_278_1.time_ >= var_281_12 + var_281_18 and arg_278_1.time_ < var_281_12 + var_281_18 + arg_281_0 then
				arg_278_1.fswtw_.percent = var_281_15

				arg_278_1.fswtw_:SetDirty()
				arg_278_1:ShowNextGo(true)

				arg_278_1.typewritterCharCountI18N = var_281_16
			end

			local var_281_19 = 3.23333333333333
			local var_281_20 = manager.audio:GetVoiceLength("story_v_out_420172", "420172067", "story_v_out_420172.awb") / 1000

			if var_281_20 > 0 and 16.2 < var_281_20 and var_281_20 + var_281_19 > arg_278_1.duration_ then
				arg_278_1.duration_ = var_281_20 + var_281_19
			end

			if var_281_19 < arg_278_1.time_ and arg_278_1.time_ <= var_281_19 + arg_281_0 then
				arg_278_1:AudioAction("play", "voice", "story_v_out_420172", "420172067", "story_v_out_420172.awb")
			end

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				local var_281_22 = arg_278_1.fswbg_.transform:Find("textbox/adapt/content") or arg_278_1.fswbg_.transform:Find("textbox/content")
				local var_281_23 = arg_278_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_281_24 = var_281_22:GetComponent("RectTransform")

				var_281_22:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_281_24.offsetMin = Vector2.New(0, -70)
				var_281_24.offsetMax = Vector2.New(0, 0)
			end

			local var_281_25 = arg_278_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_278_1.time_ and arg_278_1.time_ <= 1.96599999815226 + arg_281_0 then
				arg_278_1.var_.moveOldPos1085ui_story = var_281_25.localPosition
			end

			local var_281_26 = 0.001

			if 1.96599999815226 <= arg_278_1.time_ and arg_278_1.time_ < 1.96599999815226 + var_281_26 then
				var_281_25.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 1.96599999815226) / var_281_26)
				var_281_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_25.position).x, (manager.ui.mainCamera.transform.position - var_281_25.position).y, (manager.ui.mainCamera.transform.position - var_281_25.position).z)
				var_281_25.localEulerAngles.z = 0
				var_281_25.localEulerAngles.x = 0
				var_281_25.localEulerAngles = var_281_25.localEulerAngles
			end

			if arg_278_1.time_ >= 1.96599999815226 + var_281_26 and arg_278_1.time_ < 1.96599999815226 + var_281_26 + arg_281_0 then
				var_281_25.localPosition = Vector3.New(0, 100, 0)
				var_281_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_25.position).x, (manager.ui.mainCamera.transform.position - var_281_25.position).y, (manager.ui.mainCamera.transform.position - var_281_25.position).z)
				var_281_25.localEulerAngles.z = 0
				var_281_25.localEulerAngles.x = 0
				var_281_25.localEulerAngles = var_281_25.localEulerAngles
			end

			local var_281_27 = 1.93333333333333

			arg_278_1.isInRecall_ = false

			if var_281_27 < arg_278_1.time_ and arg_278_1.time_ <= var_281_27 + arg_281_0 then
				arg_278_1.screenFilterGo_:SetActive(false)

				for iter_281_2, iter_281_3 in pairs(arg_278_1.actors_) do
					for iter_281_4, iter_281_5 in ipairs((iter_281_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_281_5.color = iter_281_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_281_28 = 0.0666666666666669

			if var_281_27 <= arg_278_1.time_ and arg_278_1.time_ < var_281_27 + var_281_28 then
				arg_278_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_278_1.time_ - var_281_27) / var_281_28)
			end

			if arg_278_1.time_ >= var_281_27 + var_281_28 and arg_278_1.time_ < var_281_27 + var_281_28 + arg_281_0 then
				arg_278_1.screenFilterEffect_.weight = 0
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play420172068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 420172068
		arg_282_1.duration_ = 13.6

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play420172069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.fswbg_:SetActive(true)
				arg_282_1.dialog_:SetActive(false)

				arg_282_1.fswtw_.percent = 0
				arg_282_1.fswt_.text = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(420172068).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.fswt_)

				arg_282_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_282_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_282_1.fswtw_:SetDirty()

				arg_282_1.typewritterCharCountI18N = 0

				SetActive(arg_282_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_282_1:ShowNextGo(false)
			end

			local var_285_0 = 0.133333333333333

			if 0.133333333333333 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.var_.oldValueTypewriter = arg_282_1.fswtw_.percent

				SetActive(arg_282_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_282_1:ShowNextGo(false)
			end

			local var_285_1 = 35
			local var_285_2 = 2.33333333333333
			local var_285_3, var_285_4 = arg_282_1:GetPercentByPara(arg_282_1:FormatText(arg_282_1:GetWordFromCfg(420172068).content), 1)

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0

				local var_285_5 = var_285_1 <= 0 and var_285_2 or var_285_2 * ((var_285_4 - arg_282_1.typewritterCharCountI18N) / var_285_1)

				if (var_285_1 <= 0 and var_285_2 or var_285_2 * ((var_285_4 - arg_282_1.typewritterCharCountI18N) / var_285_1)) > 0 and var_285_2 < var_285_5 then
					arg_282_1.talkMaxDuration = var_285_5

					if var_285_5 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + var_285_0
					end
				end
			end

			local var_285_6 = math.max(2.33333333333333, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_6 then
				arg_282_1.fswtw_.percent = Mathf.Lerp(arg_282_1.var_.oldValueTypewriter, var_285_3, (arg_282_1.time_ - var_285_0) / var_285_6)
				arg_282_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_282_1.fswtw_:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_6 and arg_282_1.time_ < var_285_0 + var_285_6 + arg_285_0 then
				arg_282_1.fswtw_.percent = var_285_3

				arg_282_1.fswtw_:SetDirty()
				arg_282_1:ShowNextGo(true)

				arg_282_1.typewritterCharCountI18N = var_285_4
			end

			local var_285_7 = 0.133333333333333
			local var_285_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172068", "story_v_out_420172.awb") / 1000

			if var_285_8 > 0 and 13.466 < var_285_8 and var_285_8 + var_285_7 > arg_282_1.duration_ then
				arg_282_1.duration_ = var_285_8 + var_285_7
			end

			if var_285_7 < arg_282_1.time_ and arg_282_1.time_ <= var_285_7 + arg_285_0 then
				arg_282_1:AudioAction("play", "voice", "story_v_out_420172", "420172068", "story_v_out_420172.awb")
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play420172069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 420172069
		arg_286_1.duration_ = 21.07

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play420172070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.fswbg_:SetActive(true)
				arg_286_1.dialog_:SetActive(false)

				arg_286_1.fswtw_.percent = 0
				arg_286_1.fswt_.text = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(420172069).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.fswt_)

				arg_286_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_286_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_286_1.fswtw_:SetDirty()

				arg_286_1.typewritterCharCountI18N = 0

				SetActive(arg_286_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_286_1:ShowNextGo(false)
			end

			local var_289_0 = 0.133333333333333

			if 0.133333333333333 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.var_.oldValueTypewriter = arg_286_1.fswtw_.percent

				SetActive(arg_286_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_286_1:ShowNextGo(false)
			end

			local var_289_1 = 51
			local var_289_2 = 3.4
			local var_289_3, var_289_4 = arg_286_1:GetPercentByPara(arg_286_1:FormatText(arg_286_1:GetWordFromCfg(420172069).content), 1)

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				local var_289_5 = var_289_1 <= 0 and var_289_2 or var_289_2 * ((var_289_4 - arg_286_1.typewritterCharCountI18N) / var_289_1)

				if (var_289_1 <= 0 and var_289_2 or var_289_2 * ((var_289_4 - arg_286_1.typewritterCharCountI18N) / var_289_1)) > 0 and var_289_2 < var_289_5 then
					arg_286_1.talkMaxDuration = var_289_5

					if var_289_5 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + var_289_0
					end
				end
			end

			local var_289_6 = math.max(3.4, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_6 then
				arg_286_1.fswtw_.percent = Mathf.Lerp(arg_286_1.var_.oldValueTypewriter, var_289_3, (arg_286_1.time_ - var_289_0) / var_289_6)
				arg_286_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_286_1.fswtw_:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_6 and arg_286_1.time_ < var_289_0 + var_289_6 + arg_289_0 then
				arg_286_1.fswtw_.percent = var_289_3

				arg_286_1.fswtw_:SetDirty()
				arg_286_1:ShowNextGo(true)

				arg_286_1.typewritterCharCountI18N = var_289_4
			end

			local var_289_7 = 0.133333333333333
			local var_289_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172069", "story_v_out_420172.awb") / 1000

			if var_289_8 > 0 and 20.933 < var_289_8 and var_289_8 + var_289_7 > arg_286_1.duration_ then
				arg_286_1.duration_ = var_289_8 + var_289_7
			end

			if var_289_7 < arg_286_1.time_ and arg_286_1.time_ <= var_289_7 + arg_289_0 then
				arg_286_1:AudioAction("play", "voice", "story_v_out_420172", "420172069", "story_v_out_420172.awb")
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play420172070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 420172070
		arg_290_1.duration_ = 8.63

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play420172071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.fswbg_:SetActive(true)
				arg_290_1.dialog_:SetActive(false)

				arg_290_1.fswtw_.percent = 0
				arg_290_1.fswt_.text = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(420172070).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.fswt_)

				arg_290_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_290_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_290_1.fswtw_:SetDirty()

				arg_290_1.typewritterCharCountI18N = 0

				SetActive(arg_290_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_290_1:ShowNextGo(false)
			end

			local var_293_0 = 0.133333333333333

			if 0.133333333333333 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.var_.oldValueTypewriter = arg_290_1.fswtw_.percent

				SetActive(arg_290_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_290_1:ShowNextGo(false)
			end

			local var_293_1 = 15
			local var_293_2 = 1
			local var_293_3, var_293_4 = arg_290_1:GetPercentByPara(arg_290_1:FormatText(arg_290_1:GetWordFromCfg(420172070).content), 1)

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				local var_293_5 = var_293_1 <= 0 and var_293_2 or var_293_2 * ((var_293_4 - arg_290_1.typewritterCharCountI18N) / var_293_1)

				if (var_293_1 <= 0 and var_293_2 or var_293_2 * ((var_293_4 - arg_290_1.typewritterCharCountI18N) / var_293_1)) > 0 and var_293_2 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_0
					end
				end
			end

			local var_293_6 = math.max(1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_6 then
				arg_290_1.fswtw_.percent = Mathf.Lerp(arg_290_1.var_.oldValueTypewriter, var_293_3, (arg_290_1.time_ - var_293_0) / var_293_6)
				arg_290_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_290_1.fswtw_:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_6 and arg_290_1.time_ < var_293_0 + var_293_6 + arg_293_0 then
				arg_290_1.fswtw_.percent = var_293_3

				arg_290_1.fswtw_:SetDirty()
				arg_290_1:ShowNextGo(true)

				arg_290_1.typewritterCharCountI18N = var_293_4
			end

			local var_293_7 = 0.133333333333333
			local var_293_8 = manager.audio:GetVoiceLength("story_v_out_420172", "420172070", "story_v_out_420172.awb") / 1000

			if var_293_8 > 0 and 8.5 < var_293_8 and var_293_8 + var_293_7 > arg_290_1.duration_ then
				arg_290_1.duration_ = var_293_8 + var_293_7
			end

			if var_293_7 < arg_290_1.time_ and arg_290_1.time_ <= var_293_7 + arg_293_0 then
				arg_290_1:AudioAction("play", "voice", "story_v_out_420172", "420172070", "story_v_out_420172.awb")
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play420172071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 420172071
		arg_294_1.duration_ = 8.57

		local var_294_0 = {
			zh = 8.566,
			ja = 7.9
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play420172072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_9000

			if arg_294_1.bgs_.L02g == nil then
				local var_297_0 = Object.Instantiate(arg_294_1.paintGo_)

				var_297_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02g")
				var_297_0.name = "L02g"
				var_297_0.transform.parent = arg_294_1.stage_.transform
				var_297_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.bgs_.L02g = var_297_0
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				local var_297_1 = arg_294_1.bgs_.L02g

				arg_294_1.bgs_.L02g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_297_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_2 = var_297_1:GetComponent("SpriteRenderer")

				if var_297_2 and var_297_2.sprite then
					local var_297_3 = 2 * (var_297_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_297_1.transform.localScale = Vector3.New(var_297_3 / var_297_2.sprite.bounds.size.y < var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x and var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x or var_297_3 / var_297_2.sprite.bounds.size.y, var_297_3 / var_297_2.sprite.bounds.size.y < var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x and var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x or var_297_3 / var_297_2.sprite.bounds.size.y, 0)
				end

				for iter_297_0, iter_297_1 in pairs(arg_294_1.bgs_) do
					if iter_297_0 ~= "L02g" then
						iter_297_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_4 = 0

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_5 = 1

			if var_297_4 <= arg_294_1.time_ and arg_294_1.time_ < var_297_4 + var_297_5 then
				local var_297_6 = Color.New(1, 1, 1)

				var_297_6.a = Mathf.Lerp(1, 0, (arg_294_1.time_ - var_297_4) / var_297_5)
				arg_294_1.mask_.color = var_297_6
			end

			if arg_294_1.time_ >= var_297_4 + var_297_5 and arg_294_1.time_ < var_297_4 + var_297_5 + arg_297_0 then
				local var_297_7 = Color.New(1, 1, 1)

				arg_294_1.mask_.enabled = false
				var_297_7.a = 0
				arg_294_1.mask_.color = var_297_7
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.cswbg_:SetActive(false)
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				local var_297_8 = arg_294_1.var_.effectphoto1

				if not arg_294_1.var_.effectphoto1 then
					var_297_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_photo_1"), manager.ui.mainCamera.transform)
					var_297_8.name = "photo1"
					arg_294_1.var_.effectphoto1 = var_297_8
				else
					var_297_8.transform:SetParent(var_297_9000)
				end

				var_297_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_297_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_297_10 = 0

			arg_294_1.isInRecall_ = false

			if var_297_10 < arg_294_1.time_ and arg_294_1.time_ <= var_297_10 + arg_297_0 then
				arg_294_1.screenFilterGo_:SetActive(true)

				arg_294_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_297_2, iter_297_3 in pairs(arg_294_1.actors_) do
					for iter_297_4, iter_297_5 in ipairs((iter_297_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_297_5.color = iter_297_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_297_11 = 0.3

			if var_297_10 <= arg_294_1.time_ and arg_294_1.time_ < var_297_10 + var_297_11 then
				arg_294_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_294_1.time_ - var_297_10) / var_297_11)
			end

			if arg_294_1.time_ >= var_297_10 + var_297_11 and arg_294_1.time_ < var_297_10 + var_297_11 + arg_297_0 then
				arg_294_1.screenFilterEffect_.weight = 1
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.fswbg_:SetActive(false)
				arg_294_1.dialog_:SetActive(false)
				SetActive(arg_294_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_294_1:ShowNextGo(false)
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_12 = 1
			local var_297_13 = 0.675

			if 1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_12 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_14 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_14:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_15 = arg_294_1:GetWordFromCfg(420172071)
				local var_297_16 = arg_294_1:FormatText(var_297_15.content)

				arg_294_1.text_.text = var_297_16

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_18 = 27 <= 0 and var_297_13 or var_297_13 * (utf8.len(var_297_16) / 27)

				if (27 <= 0 and var_297_13 or var_297_13 * (utf8.len(var_297_16) / 27)) > 0 and var_297_13 < var_297_18 then
					arg_294_1.talkMaxDuration = var_297_18
					var_297_12 = var_297_12 + 0.3

					if var_297_18 + var_297_12 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_18 + var_297_12
					end
				end

				arg_294_1.text_.text = var_297_16
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172071", "story_v_out_420172.awb") ~= 0 then
					local var_297_19 = manager.audio:GetVoiceLength("story_v_out_420172", "420172071", "story_v_out_420172.awb") / 1000

					if var_297_19 + var_297_12 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_19 + var_297_12
					end

					if var_297_15.prefab_name ~= "" and arg_294_1.actors_[var_297_15.prefab_name] ~= nil then
						local var_297_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_15.prefab_name].transform, "story_v_out_420172", "420172071", "story_v_out_420172.awb")

						arg_294_1:RecordAudio("420172071", var_297_20)
						arg_294_1:RecordAudio("420172071", var_297_20)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_420172", "420172071", "story_v_out_420172.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_420172", "420172071", "story_v_out_420172.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_21 = var_297_12 + 0.3
			local var_297_22 = math.max(var_297_13, arg_294_1.talkMaxDuration)

			if var_297_12 + 0.3 <= arg_294_1.time_ and arg_294_1.time_ < var_297_21 + var_297_22 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_21) / var_297_22

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_21 + var_297_22 and arg_294_1.time_ < var_297_21 + var_297_22 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play420172072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 420172072
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play420172073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.675

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_1 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(420172072).content)

				arg_300_1.text_.text = var_303_1

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_3 = 21 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 21)

				if (21 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 21)) > 0 and var_303_0 < var_303_3 then
					arg_300_1.talkMaxDuration = var_303_3

					if var_303_3 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_3 + 0
					end
				end

				arg_300_1.text_.text = var_303_1
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_4 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_4

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play420172073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 420172073
		arg_304_1.duration_ = 1.9

		local var_304_0 = {
			zh = 1.9,
			ja = 1.533
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play420172074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0.2

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:GetWordFromCfg(420172073)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 3 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 3)

				if (3 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 3)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172073", "story_v_out_420172.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_out_420172", "420172073", "story_v_out_420172.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_out_420172", "420172073", "story_v_out_420172.awb")

						arg_304_1:RecordAudio("420172073", var_307_6)
						arg_304_1:RecordAudio("420172073", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_420172", "420172073", "story_v_out_420172.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_420172", "420172073", "story_v_out_420172.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play420172074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 420172074
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play420172075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0.625

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_1 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(420172074).content)

				arg_308_1.text_.text = var_311_1

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_3 = 25 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 25)

				if (25 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 25)) > 0 and var_311_0 < var_311_3 then
					arg_308_1.talkMaxDuration = var_311_3

					if var_311_3 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_3 + 0
					end
				end

				arg_308_1.text_.text = var_311_1
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_4 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_4

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play420172075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 420172075
		arg_312_1.duration_ = 11

		local var_312_0 = {
			zh = 9.366,
			ja = 11
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play420172076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.675

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_1 = arg_312_1:GetWordFromCfg(420172075)
				local var_315_2 = arg_312_1:FormatText(var_315_1.content)

				arg_312_1.text_.text = var_315_2

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 27 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 27)

				if (27 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 27)) > 0 and var_315_0 < var_315_4 then
					arg_312_1.talkMaxDuration = var_315_4

					if var_315_4 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_4 + 0
					end
				end

				arg_312_1.text_.text = var_315_2
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172075", "story_v_out_420172.awb") ~= 0 then
					local var_315_5 = manager.audio:GetVoiceLength("story_v_out_420172", "420172075", "story_v_out_420172.awb") / 1000

					if var_315_5 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + 0
					end

					if var_315_1.prefab_name ~= "" and arg_312_1.actors_[var_315_1.prefab_name] ~= nil then
						local var_315_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_1.prefab_name].transform, "story_v_out_420172", "420172075", "story_v_out_420172.awb")

						arg_312_1:RecordAudio("420172075", var_315_6)
						arg_312_1:RecordAudio("420172075", var_315_6)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_420172", "420172075", "story_v_out_420172.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_420172", "420172075", "story_v_out_420172.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_7 and arg_312_1.time_ < 0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play420172076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 420172076
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play420172077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.725

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_1 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(420172076).content)

				arg_316_1.text_.text = var_319_1

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_3 = 29 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_1) / 29)

				if (29 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_1) / 29)) > 0 and var_319_0 < var_319_3 then
					arg_316_1.talkMaxDuration = var_319_3

					if var_319_3 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_3 + 0
					end
				end

				arg_316_1.text_.text = var_319_1
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_4 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_4 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_4

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_4 and arg_316_1.time_ < 0 + var_319_4 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play420172077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 420172077
		arg_320_1.duration_ = 4.73

		local var_320_0 = {
			zh = 2.833,
			ja = 4.733
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play420172078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.25

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:GetWordFromCfg(420172077)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 10 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 10)

				if (10 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 10)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172077", "story_v_out_420172.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_420172", "420172077", "story_v_out_420172.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_420172", "420172077", "story_v_out_420172.awb")

						arg_320_1:RecordAudio("420172077", var_323_6)
						arg_320_1:RecordAudio("420172077", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_420172", "420172077", "story_v_out_420172.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_420172", "420172077", "story_v_out_420172.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play420172078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 420172078
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play420172079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				local var_327_0 = arg_324_1.var_.effectphoto2

				if not arg_324_1.var_.effectphoto2 then
					var_327_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_photo_2"), manager.ui.mainCamera.transform)
					var_327_0.name = "photo2"
					arg_324_1.var_.effectphoto2 = var_327_0
				else
					var_327_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_327_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_327_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_327_2 = "L01"

			if arg_324_1.bgs_.L01 == nil then
				local var_327_3 = Object.Instantiate(arg_324_1.paintGo_)

				var_327_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_327_2)
				var_327_3.name = var_327_2
				var_327_3.transform.parent = arg_324_1.stage_.transform
				var_327_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_324_1.bgs_[var_327_2] = var_327_3
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				local var_327_4 = arg_324_1.bgs_.L01

				arg_324_1.bgs_.L01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_327_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_327_5 = var_327_4:GetComponent("SpriteRenderer")

				if var_327_5 and var_327_5.sprite then
					local var_327_6 = 2 * (var_327_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_327_4.transform.localScale = Vector3.New(var_327_6 / var_327_5.sprite.bounds.size.y < var_327_6 * manager.ui.mainCameraCom_.aspect / var_327_5.sprite.bounds.size.x and var_327_6 * manager.ui.mainCameraCom_.aspect / var_327_5.sprite.bounds.size.x or var_327_6 / var_327_5.sprite.bounds.size.y, var_327_6 / var_327_5.sprite.bounds.size.y < var_327_6 * manager.ui.mainCameraCom_.aspect / var_327_5.sprite.bounds.size.x and var_327_6 * manager.ui.mainCameraCom_.aspect / var_327_5.sprite.bounds.size.x or var_327_6 / var_327_5.sprite.bounds.size.y, 0)
				end

				for iter_327_0, iter_327_1 in pairs(arg_324_1.bgs_) do
					if iter_327_0 ~= "L01" then
						iter_327_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_327_7 = 0
			local var_327_8 = 0.233333333333333

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_7 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_9 = arg_324_1:GetWordFromCfg(420172078)
				local var_327_10 = arg_324_1:FormatText(var_327_9.content)

				arg_324_1.text_.text = var_327_10

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_12 = 5 <= 0 and var_327_8 or var_327_8 * (utf8.len(var_327_10) / 5)

				if (5 <= 0 and var_327_8 or var_327_8 * (utf8.len(var_327_10) / 5)) > 0 and var_327_8 < var_327_12 then
					arg_324_1.talkMaxDuration = var_327_12

					if var_327_12 + var_327_7 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_12 + var_327_7
					end
				end

				arg_324_1.text_.text = var_327_10
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172078", "story_v_out_420172.awb") ~= 0 then
					local var_327_13 = manager.audio:GetVoiceLength("story_v_out_420172", "420172078", "story_v_out_420172.awb") / 1000

					if var_327_13 + var_327_7 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_13 + var_327_7
					end

					if var_327_9.prefab_name ~= "" and arg_324_1.actors_[var_327_9.prefab_name] ~= nil then
						local var_327_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_9.prefab_name].transform, "story_v_out_420172", "420172078", "story_v_out_420172.awb")

						arg_324_1:RecordAudio("420172078", var_327_14)
						arg_324_1:RecordAudio("420172078", var_327_14)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_420172", "420172078", "story_v_out_420172.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_420172", "420172078", "story_v_out_420172.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_15 = math.max(var_327_8, arg_324_1.talkMaxDuration)

			if var_327_7 <= arg_324_1.time_ and arg_324_1.time_ < var_327_7 + var_327_15 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_7) / var_327_15

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_7 + var_327_15 and arg_324_1.time_ < var_327_7 + var_327_15 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play420172079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 420172079
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play420172080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0.475

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_1 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(420172079).content)

				arg_328_1.text_.text = var_331_1

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_3 = 19 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 19)

				if (19 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 19)) > 0 and var_331_0 < var_331_3 then
					arg_328_1.talkMaxDuration = var_331_3

					if var_331_3 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_3 + 0
					end
				end

				arg_328_1.text_.text = var_331_1
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_4 = math.max(var_331_0, arg_328_1.talkMaxDuration)

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_4 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - 0) / var_331_4

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= 0 + var_331_4 and arg_328_1.time_ < 0 + var_331_4 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play420172080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 420172080
		arg_332_1.duration_ = 6.53

		local var_332_0 = {
			zh = 6.233,
			ja = 6.533
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play420172081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0.375

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_1 = arg_332_1:GetWordFromCfg(420172080)
				local var_335_2 = arg_332_1:FormatText(var_335_1.content)

				arg_332_1.text_.text = var_335_2

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_4 = 15 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 15)

				if (15 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 15)) > 0 and var_335_0 < var_335_4 then
					arg_332_1.talkMaxDuration = var_335_4

					if var_335_4 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_4 + 0
					end
				end

				arg_332_1.text_.text = var_335_2
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172080", "story_v_out_420172.awb") ~= 0 then
					local var_335_5 = manager.audio:GetVoiceLength("story_v_out_420172", "420172080", "story_v_out_420172.awb") / 1000

					if var_335_5 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + 0
					end

					if var_335_1.prefab_name ~= "" and arg_332_1.actors_[var_335_1.prefab_name] ~= nil then
						local var_335_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_1.prefab_name].transform, "story_v_out_420172", "420172080", "story_v_out_420172.awb")

						arg_332_1:RecordAudio("420172080", var_335_6)
						arg_332_1:RecordAudio("420172080", var_335_6)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_420172", "420172080", "story_v_out_420172.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_420172", "420172080", "story_v_out_420172.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_7 = math.max(var_335_0, arg_332_1.talkMaxDuration)

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_7 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - 0) / var_335_7

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= 0 + var_335_7 and arg_332_1.time_ < 0 + var_335_7 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play420172081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 420172081
		arg_336_1.duration_ = 7.23

		local var_336_0 = {
			zh = 5.633,
			ja = 7.233
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play420172082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				local var_339_0 = arg_336_1.var_.effectphoto3

				if not arg_336_1.var_.effectphoto3 then
					var_339_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_photo_3"), manager.ui.mainCamera.transform)
					var_339_0.name = "photo3"
					arg_336_1.var_.effectphoto3 = var_339_0
				else
					var_339_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_339_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_339_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_339_2 = "ST0601"

			if arg_336_1.bgs_.ST0601 == nil then
				local var_339_3 = Object.Instantiate(arg_336_1.paintGo_)

				var_339_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_339_2)
				var_339_3.name = var_339_2
				var_339_3.transform.parent = arg_336_1.stage_.transform
				var_339_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_336_1.bgs_[var_339_2] = var_339_3
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				local var_339_4 = arg_336_1.bgs_.ST0601

				arg_336_1.bgs_.ST0601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_339_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_339_5 = var_339_4:GetComponent("SpriteRenderer")

				if var_339_5 and var_339_5.sprite then
					local var_339_6 = 2 * (var_339_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_339_4.transform.localScale = Vector3.New(var_339_6 / var_339_5.sprite.bounds.size.y < var_339_6 * manager.ui.mainCameraCom_.aspect / var_339_5.sprite.bounds.size.x and var_339_6 * manager.ui.mainCameraCom_.aspect / var_339_5.sprite.bounds.size.x or var_339_6 / var_339_5.sprite.bounds.size.y, var_339_6 / var_339_5.sprite.bounds.size.y < var_339_6 * manager.ui.mainCameraCom_.aspect / var_339_5.sprite.bounds.size.x and var_339_6 * manager.ui.mainCameraCom_.aspect / var_339_5.sprite.bounds.size.x or var_339_6 / var_339_5.sprite.bounds.size.y, 0)
				end

				for iter_339_0, iter_339_1 in pairs(arg_336_1.bgs_) do
					if iter_339_0 ~= "ST0601" then
						iter_339_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_339_7 = 0
			local var_339_8 = 0.525

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_7 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_9 = arg_336_1:GetWordFromCfg(420172081)
				local var_339_10 = arg_336_1:FormatText(var_339_9.content)

				arg_336_1.text_.text = var_339_10

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_12 = 21 <= 0 and var_339_8 or var_339_8 * (utf8.len(var_339_10) / 21)

				if (21 <= 0 and var_339_8 or var_339_8 * (utf8.len(var_339_10) / 21)) > 0 and var_339_8 < var_339_12 then
					arg_336_1.talkMaxDuration = var_339_12

					if var_339_12 + var_339_7 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_12 + var_339_7
					end
				end

				arg_336_1.text_.text = var_339_10
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172081", "story_v_out_420172.awb") ~= 0 then
					local var_339_13 = manager.audio:GetVoiceLength("story_v_out_420172", "420172081", "story_v_out_420172.awb") / 1000

					if var_339_13 + var_339_7 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_13 + var_339_7
					end

					if var_339_9.prefab_name ~= "" and arg_336_1.actors_[var_339_9.prefab_name] ~= nil then
						local var_339_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_9.prefab_name].transform, "story_v_out_420172", "420172081", "story_v_out_420172.awb")

						arg_336_1:RecordAudio("420172081", var_339_14)
						arg_336_1:RecordAudio("420172081", var_339_14)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_420172", "420172081", "story_v_out_420172.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_420172", "420172081", "story_v_out_420172.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_15 = math.max(var_339_8, arg_336_1.talkMaxDuration)

			if var_339_7 <= arg_336_1.time_ and arg_336_1.time_ < var_339_7 + var_339_15 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_7) / var_339_15

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_7 + var_339_15 and arg_336_1.time_ < var_339_7 + var_339_15 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play420172082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 420172082
		arg_340_1.duration_ = 9.87

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play420172083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				local var_343_0 = arg_340_1.bgs_.STwhite

				arg_340_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_343_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_343_1 = var_343_0:GetComponent("SpriteRenderer")

				if var_343_1 and var_343_1.sprite then
					local var_343_2 = 2 * (var_343_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_343_0.transform.localScale = Vector3.New(var_343_2 / var_343_1.sprite.bounds.size.y < var_343_2 * manager.ui.mainCameraCom_.aspect / var_343_1.sprite.bounds.size.x and var_343_2 * manager.ui.mainCameraCom_.aspect / var_343_1.sprite.bounds.size.x or var_343_2 / var_343_1.sprite.bounds.size.y, var_343_2 / var_343_1.sprite.bounds.size.y < var_343_2 * manager.ui.mainCameraCom_.aspect / var_343_1.sprite.bounds.size.x and var_343_2 * manager.ui.mainCameraCom_.aspect / var_343_1.sprite.bounds.size.x or var_343_2 / var_343_1.sprite.bounds.size.y, 0)
				end

				for iter_343_0, iter_343_1 in pairs(arg_340_1.bgs_) do
					if iter_343_0 ~= "STwhite" then
						iter_343_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_343_3 = 0

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_3 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_4 = 1

			if var_343_3 <= arg_340_1.time_ and arg_340_1.time_ < var_343_3 + var_343_4 then
				local var_343_5 = Color.New(1, 1, 1)

				var_343_5.a = Mathf.Lerp(1, 0, (arg_340_1.time_ - var_343_3) / var_343_4)
				arg_340_1.mask_.color = var_343_5
			end

			if arg_340_1.time_ >= var_343_3 + var_343_4 and arg_340_1.time_ < var_343_3 + var_343_4 + arg_343_0 then
				local var_343_6 = Color.New(1, 1, 1)

				arg_340_1.mask_.enabled = false
				var_343_6.a = 0
				arg_340_1.mask_.color = var_343_6
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				if arg_340_1.var_.effectphoto1 then
					Object.Destroy(arg_340_1.var_.effectphoto1)

					arg_340_1.var_.effectphoto1 = nil
				end
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				if arg_340_1.var_.effectphoto2 then
					Object.Destroy(arg_340_1.var_.effectphoto2)

					arg_340_1.var_.effectphoto2 = nil
				end
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				if arg_340_1.var_.effectphoto3 then
					Object.Destroy(arg_340_1.var_.effectphoto3)

					arg_340_1.var_.effectphoto3 = nil
				end
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.fswbg_:SetActive(false)
				arg_340_1.dialog_:SetActive(false)
				SetActive(arg_340_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_340_1:ShowNextGo(false)
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.cswbg_:SetActive(true)

				local var_343_10 = arg_340_1.cswt_:GetComponent("RectTransform")

				arg_340_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_343_10.offsetMin = Vector2.New(0, 0)
				var_343_10.offsetMax = Vector2.New(0, 130)
				arg_340_1.cswt_.text = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(419156).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.cswt_)

				arg_340_1.cswt_.fontSize = 120
				arg_340_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_340_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_340_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				local var_343_11 = arg_340_1.fswbg_.transform:Find("textbox/adapt/content") or arg_340_1.fswbg_.transform:Find("textbox/content")
				local var_343_12 = arg_340_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_343_13 = var_343_11:GetComponent("RectTransform")

				var_343_11:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_343_13.offsetMin = Vector2.New(0, -70)
				var_343_13.offsetMax = Vector2.New(0, 0)
			end

			local var_343_14 = 0

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_14 + arg_343_0 then
				arg_340_1.allBtn_.enabled = false
			end

			if arg_340_1.time_ >= var_343_14 + 1.56666666666667 and arg_340_1.time_ < var_343_14 + 1.56666666666667 + arg_343_0 then
				arg_340_1.allBtn_.enabled = true
			end

			local var_343_15 = 0

			arg_340_1.isInRecall_ = false

			if var_343_15 < arg_340_1.time_ and arg_340_1.time_ <= var_343_15 + arg_343_0 then
				arg_340_1.screenFilterGo_:SetActive(false)

				for iter_343_2, iter_343_3 in pairs(arg_340_1.actors_) do
					for iter_343_4, iter_343_5 in ipairs((iter_343_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_343_5.color = iter_343_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_343_16 = 0.0666666666666667

			if var_343_15 <= arg_340_1.time_ and arg_340_1.time_ < var_343_15 + var_343_16 then
				arg_340_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_340_1.time_ - var_343_15) / var_343_16)
			end

			if arg_340_1.time_ >= var_343_15 + var_343_16 and arg_340_1.time_ < var_343_15 + var_343_16 + arg_343_0 then
				arg_340_1.screenFilterEffect_.weight = 0
			end

			local var_343_17 = 0
			local var_343_18 = manager.audio:GetVoiceLength("story_v_out_420172", "420172082", "story_v_out_420172.awb") / 1000

			if var_343_18 > 0 and 9.866 < var_343_18 and var_343_18 + var_343_17 > arg_340_1.duration_ then
				arg_340_1.duration_ = var_343_18 + var_343_17
			end

			if var_343_17 < arg_340_1.time_ and arg_340_1.time_ <= var_343_17 + arg_343_0 then
				arg_340_1:AudioAction("play", "voice", "story_v_out_420172", "420172082", "story_v_out_420172.awb")
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play420172083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 420172083
		arg_344_1.duration_ = 6.87

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play420172084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_9000

			if arg_344_1.bgs_.SS2005 == nil then
				local var_347_0 = Object.Instantiate(arg_344_1.paintGo_)

				var_347_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2005")
				var_347_0.name = "SS2005"
				var_347_0.transform.parent = arg_344_1.stage_.transform
				var_347_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_344_1.bgs_.SS2005 = var_347_0
			end

			if 0.666666666666667 < arg_344_1.time_ and arg_344_1.time_ <= 0.666666666666667 + arg_347_0 then
				local var_347_1 = arg_344_1.bgs_.SS2005

				arg_344_1.bgs_.SS2005.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_347_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_347_2 = var_347_1:GetComponent("SpriteRenderer")

				if var_347_2 and var_347_2.sprite then
					local var_347_3 = 2 * (var_347_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_347_1.transform.localScale = Vector3.New(var_347_3 / var_347_2.sprite.bounds.size.y < var_347_3 * manager.ui.mainCameraCom_.aspect / var_347_2.sprite.bounds.size.x and var_347_3 * manager.ui.mainCameraCom_.aspect / var_347_2.sprite.bounds.size.x or var_347_3 / var_347_2.sprite.bounds.size.y, var_347_3 / var_347_2.sprite.bounds.size.y < var_347_3 * manager.ui.mainCameraCom_.aspect / var_347_2.sprite.bounds.size.x and var_347_3 * manager.ui.mainCameraCom_.aspect / var_347_2.sprite.bounds.size.x or var_347_3 / var_347_2.sprite.bounds.size.y, 0)
				end

				for iter_347_0, iter_347_1 in pairs(arg_344_1.bgs_) do
					if iter_347_0 ~= "SS2005" then
						iter_347_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.cswbg_:SetActive(false)
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.fswbg_:SetActive(false)
				arg_344_1.dialog_:SetActive(false)
				SetActive(arg_344_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_344_1:ShowNextGo(false)
			end

			local var_347_4 = 0

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1.allBtn_.enabled = false
			end

			if arg_344_1.time_ >= var_347_4 + 1.86666666666667 and arg_344_1.time_ < var_347_4 + 1.86666666666667 + arg_347_0 then
				arg_344_1.allBtn_.enabled = true
			end

			if 0.666666666666667 < arg_344_1.time_ and arg_344_1.time_ <= 0.666666666666667 + arg_347_0 then
				local var_347_5 = arg_344_1.var_.effect2083

				if not arg_344_1.var_.effect2083 then
					var_347_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_347_5.name = "2083"
					arg_344_1.var_.effect2083 = var_347_5
				else
					var_347_5.transform:SetParent(var_347_9000)
				end

				var_347_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_347_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.96666666666667 < arg_344_1.time_ and arg_344_1.time_ <= 1.96666666666667 + arg_347_0 then
				if arg_344_1.var_.effect2083 then
					Object.Destroy(arg_344_1.var_.effect2083)

					arg_344_1.var_.effect2083 = nil
				end
			end

			local var_347_8 = 0

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_8 + arg_347_0 then
				arg_344_1.mask_.enabled = true
				arg_344_1.mask_.raycastTarget = true

				arg_344_1:SetGaussion(false)
			end

			local var_347_9 = 0.666666666666667

			if var_347_8 <= arg_344_1.time_ and arg_344_1.time_ < var_347_8 + var_347_9 then
				local var_347_10 = Color.New(1, 1, 1)

				var_347_10.a = Mathf.Lerp(1, 0, (arg_344_1.time_ - var_347_8) / var_347_9)
				arg_344_1.mask_.color = var_347_10
			end

			if arg_344_1.time_ >= var_347_8 + var_347_9 and arg_344_1.time_ < var_347_8 + var_347_9 + arg_347_0 then
				local var_347_11 = Color.New(1, 1, 1)

				arg_344_1.mask_.enabled = false
				var_347_11.a = 0
				arg_344_1.mask_.color = var_347_11
			end

			if arg_344_1.frameCnt_ <= 1 then
				arg_344_1.dialog_:SetActive(false)
			end

			local var_347_12 = 1.86666666666667
			local var_347_13 = 0.2

			if 1.86666666666667 < arg_344_1.time_ and arg_344_1.time_ <= var_347_12 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0

				arg_344_1.dialog_:SetActive(true)

				arg_344_1.dialogCg_.alpha = 0

				local var_347_14 = LeanTween.value(arg_344_1.dialog_, 0, 1, 0.3)

				var_347_14:setOnUpdate(LuaHelper.FloatAction(function(arg_348_0)
					arg_344_1.dialogCg_.alpha = arg_348_0
				end))
				var_347_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_344_1.dialog_)
					var_347_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_344_1.duration_ = arg_344_1.duration_ + 0.3

				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_15 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(420172083).content)

				arg_344_1.text_.text = var_347_15

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_17 = 8 <= 0 and var_347_13 or var_347_13 * (utf8.len(var_347_15) / 8)

				if (8 <= 0 and var_347_13 or var_347_13 * (utf8.len(var_347_15) / 8)) > 0 and var_347_13 < var_347_17 then
					arg_344_1.talkMaxDuration = var_347_17
					var_347_12 = var_347_12 + 0.3

					if var_347_17 + var_347_12 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_17 + var_347_12
					end
				end

				arg_344_1.text_.text = var_347_15
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_18 = var_347_12 + 0.3
			local var_347_19 = math.max(var_347_13, arg_344_1.talkMaxDuration)

			if var_347_12 + 0.3 <= arg_344_1.time_ and arg_344_1.time_ < var_347_18 + var_347_19 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_18) / var_347_19

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_18 + var_347_19 and arg_344_1.time_ < var_347_18 + var_347_19 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play420172084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 420172084
		arg_350_1.duration_ = 7

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play420172085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				local var_353_0 = arg_350_1.bgs_.ST67

				arg_350_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_353_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_353_1 = var_353_0:GetComponent("SpriteRenderer")

				if var_353_1 and var_353_1.sprite then
					local var_353_2 = 2 * (var_353_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_353_0.transform.localScale = Vector3.New(var_353_2 / var_353_1.sprite.bounds.size.y < var_353_2 * manager.ui.mainCameraCom_.aspect / var_353_1.sprite.bounds.size.x and var_353_2 * manager.ui.mainCameraCom_.aspect / var_353_1.sprite.bounds.size.x or var_353_2 / var_353_1.sprite.bounds.size.y, var_353_2 / var_353_1.sprite.bounds.size.y < var_353_2 * manager.ui.mainCameraCom_.aspect / var_353_1.sprite.bounds.size.x and var_353_2 * manager.ui.mainCameraCom_.aspect / var_353_1.sprite.bounds.size.x or var_353_2 / var_353_1.sprite.bounds.size.y, 0)
				end

				for iter_353_0, iter_353_1 in pairs(arg_350_1.bgs_) do
					if iter_353_0 ~= "ST67" then
						iter_353_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_353_3 = 2

			if 2 < arg_350_1.time_ and arg_350_1.time_ <= var_353_3 + arg_353_0 then
				arg_350_1.allBtn_.enabled = false
			end

			if arg_350_1.time_ >= var_353_3 + 0.3 and arg_350_1.time_ < var_353_3 + 0.3 + arg_353_0 then
				arg_350_1.allBtn_.enabled = true
			end

			local var_353_4 = 0

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1.mask_.enabled = true
				arg_350_1.mask_.raycastTarget = true

				arg_350_1:SetGaussion(false)
			end

			local var_353_5 = 2

			if var_353_4 <= arg_350_1.time_ and arg_350_1.time_ < var_353_4 + var_353_5 then
				local var_353_6 = Color.New(1, 1, 1)

				var_353_6.a = Mathf.Lerp(1, 0, (arg_350_1.time_ - var_353_4) / var_353_5)
				arg_350_1.mask_.color = var_353_6
			end

			if arg_350_1.time_ >= var_353_4 + var_353_5 and arg_350_1.time_ < var_353_4 + var_353_5 + arg_353_0 then
				local var_353_7 = Color.New(1, 1, 1)

				arg_350_1.mask_.enabled = false
				var_353_7.a = 0
				arg_350_1.mask_.color = var_353_7
			end

			if 2.2 < arg_350_1.time_ and arg_350_1.time_ <= 2.2 + arg_353_0 then
				arg_350_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_camera", "")
			end

			if arg_350_1.frameCnt_ <= 1 then
				arg_350_1.dialog_:SetActive(false)
			end

			local var_353_9 = 2
			local var_353_10 = 0.875

			if 2 < arg_350_1.time_ and arg_350_1.time_ <= var_353_9 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0

				arg_350_1.dialog_:SetActive(true)

				arg_350_1.dialogCg_.alpha = 0

				local var_353_11 = LeanTween.value(arg_350_1.dialog_, 0, 1, 0.3)

				var_353_11:setOnUpdate(LuaHelper.FloatAction(function(arg_354_0)
					arg_350_1.dialogCg_.alpha = arg_354_0
				end))
				var_353_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_350_1.dialog_)
					var_353_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_350_1.duration_ = arg_350_1.duration_ + 0.3

				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_12 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(420172084).content)

				arg_350_1.text_.text = var_353_12

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_14 = 35 <= 0 and var_353_10 or var_353_10 * (utf8.len(var_353_12) / 35)

				if (35 <= 0 and var_353_10 or var_353_10 * (utf8.len(var_353_12) / 35)) > 0 and var_353_10 < var_353_14 then
					arg_350_1.talkMaxDuration = var_353_14
					var_353_9 = var_353_9 + 0.3

					if var_353_14 + var_353_9 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_14 + var_353_9
					end
				end

				arg_350_1.text_.text = var_353_12
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_15 = var_353_9 + 0.3
			local var_353_16 = math.max(var_353_10, arg_350_1.talkMaxDuration)

			if var_353_9 + 0.3 <= arg_350_1.time_ and arg_350_1.time_ < var_353_15 + var_353_16 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_15) / var_353_16

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_15 + var_353_16 and arg_350_1.time_ < var_353_15 + var_353_16 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play420172085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 420172085
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play420172086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.325

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_1 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(420172085).content)

				arg_356_1.text_.text = var_359_1

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_3 = 13 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_1) / 13)

				if (13 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_1) / 13)) > 0 and var_359_0 < var_359_3 then
					arg_356_1.talkMaxDuration = var_359_3

					if var_359_3 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_3 + 0
					end
				end

				arg_356_1.text_.text = var_359_1
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_4 = math.max(var_359_0, arg_356_1.talkMaxDuration)

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_4 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - 0) / var_359_4

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= 0 + var_359_4 and arg_356_1.time_ < 0 + var_359_4 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play420172086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 420172086
		arg_360_1.duration_ = 2

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play420172087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos1061ui_story = arg_360_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_363_0 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 then
				arg_360_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_360_1.time_ - 0) / var_363_0)
				arg_360_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).z)
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles = arg_360_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 then
				arg_360_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_360_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).z)
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles = arg_360_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_363_1 = arg_360_1.actors_["1061ui_story"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect1061ui_story == nil then
				arg_360_1.var_.characterEffect1061ui_story = var_363_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_2 and not isNil(var_363_1) then
				if arg_360_1.var_.characterEffect1061ui_story and not isNil(var_363_1) then
					arg_360_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= 0 + var_363_2 and arg_360_1.time_ < 0 + var_363_2 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect1061ui_story then
				arg_360_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_363_4 = 0
			local var_363_5 = 0.075

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_6 = arg_360_1:GetWordFromCfg(420172086)
				local var_363_7 = arg_360_1:FormatText(var_363_6.content)

				arg_360_1.text_.text = var_363_7

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_9 = 3 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 3)

				if (3 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 3)) > 0 and var_363_5 < var_363_9 then
					arg_360_1.talkMaxDuration = var_363_9

					if var_363_9 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_9 + var_363_4
					end
				end

				arg_360_1.text_.text = var_363_7
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420172", "420172086", "story_v_out_420172.awb") ~= 0 then
					local var_363_10 = manager.audio:GetVoiceLength("story_v_out_420172", "420172086", "story_v_out_420172.awb") / 1000

					if var_363_10 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_10 + var_363_4
					end

					if var_363_6.prefab_name ~= "" and arg_360_1.actors_[var_363_6.prefab_name] ~= nil then
						local var_363_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_6.prefab_name].transform, "story_v_out_420172", "420172086", "story_v_out_420172.awb")

						arg_360_1:RecordAudio("420172086", var_363_11)
						arg_360_1:RecordAudio("420172086", var_363_11)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_420172", "420172086", "story_v_out_420172.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_420172", "420172086", "story_v_out_420172.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_12 = math.max(var_363_5, arg_360_1.talkMaxDuration)

			if var_363_4 <= arg_360_1.time_ and arg_360_1.time_ < var_363_4 + var_363_12 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_4) / var_363_12

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_4 + var_363_12 and arg_360_1.time_ < var_363_4 + var_363_12 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play420172087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 420172087
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
			arg_364_1.auto_ = false
		end

		function arg_364_1.playNext_(arg_366_0)
			arg_364_1.onStoryFinished_()
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos1061ui_story = arg_364_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_367_0 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 then
				arg_364_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_364_1.time_ - 0) / var_367_0)
				arg_364_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).z)
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles = arg_364_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 then
				arg_364_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_364_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).z)
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles = arg_364_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if 1.13333333333333 < arg_364_1.time_ and arg_364_1.time_ <= 1.13333333333333 + arg_367_0 then
				arg_364_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_run", "")
			end

			local var_367_2 = 0
			local var_367_3 = 1.05

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_2 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_4 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(420172087).content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_6 = 42 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_4) / 42)

				if (42 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_4) / 42)) > 0 and var_367_3 < var_367_6 then
					arg_364_1.talkMaxDuration = var_367_6

					if var_367_6 + var_367_2 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_2
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_3, arg_364_1.talkMaxDuration)

			if var_367_2 <= arg_364_1.time_ and arg_364_1.time_ < var_367_2 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_2) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_2 + var_367_7 and arg_364_1.time_ < var_367_2 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST67",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/L02g",
		"TextureConfig/Background/L01",
		"TextureConfig/Background/ST0601",
		"TextureConfig/Background/SS2005"
	},
	voices = {
		"story_v_out_420172.awb"
	}
}

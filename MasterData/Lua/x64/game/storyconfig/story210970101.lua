return {
	Play1109701001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109701001
		arg_1_1.duration_ = 9.37

		local var_1_0 = {
			zh = 7.40000000298023,
			ja = 9.36600000298023
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
				arg_1_0:Play1109701002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST12 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_4_0.name = "ST12"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST12 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST12

				arg_1_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST12" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "1019ui_story"

			if arg_1_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1019ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1019ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_20 = "ST12_blur"

			if arg_1_1.bgs_.ST12_blur == nil then
				local var_4_21 = Object.Instantiate(arg_1_1.blurPaintGo_)

				var_4_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_20)
				var_4_21.name = var_4_20
				var_4_21.transform.parent = arg_1_1.stage_.transform
				var_4_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_20] = var_4_21
			end

			local var_4_22 = 0
			local var_4_23 = arg_1_1.bgs_[var_4_20]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				var_4_23.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_24 = var_4_23:GetComponent("SpriteRenderer")

				if var_4_24 and var_4_24.sprite then
					local var_4_25 = 2 * (var_4_23.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_23.transform.localScale = Vector3.New(var_4_25 / var_4_24.sprite.bounds.size.y < var_4_25 * manager.ui.mainCameraCom_.aspect / var_4_24.sprite.bounds.size.x and var_4_25 * manager.ui.mainCameraCom_.aspect / var_4_24.sprite.bounds.size.x or var_4_25 / var_4_24.sprite.bounds.size.y, var_4_25 / var_4_24.sprite.bounds.size.y < var_4_25 * manager.ui.mainCameraCom_.aspect / var_4_24.sprite.bounds.size.x and var_4_25 * manager.ui.mainCameraCom_.aspect / var_4_24.sprite.bounds.size.x or var_4_25 / var_4_24.sprite.bounds.size.y, 0)
				end
			end

			local var_4_26 = 2.00000000298023

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_26 then
				local var_4_27 = Color.New(1, 1, 1)

				var_4_27.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_22) / var_4_26)

				var_4_23:GetComponent("SpriteRenderer").material:SetColor("_Color", var_4_27)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_28 = 2.00000000298023
			local var_4_29 = 0.625

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[949].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_31 = arg_1_1:GetWordFromCfg(1109701001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 25 <= 0 and var_4_29 or var_4_29 * (utf8.len(var_4_32) / 25)

				if (25 <= 0 and var_4_29 or var_4_29 * (utf8.len(var_4_32) / 25)) > 0 and var_4_29 < var_4_34 then
					arg_1_1.talkMaxDuration = var_4_34
					var_4_28 = var_4_28 + 0.3

					if var_4_34 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701001", "story_v_side_new_1109701.awb") ~= 0 then
					local var_4_35 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701001", "story_v_side_new_1109701.awb") / 1000

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end

					if var_4_31.prefab_name ~= "" and arg_1_1.actors_[var_4_31.prefab_name] ~= nil then
						local var_4_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_31.prefab_name].transform, "story_v_side_new_1109701", "1109701001", "story_v_side_new_1109701.awb")

						arg_1_1:RecordAudio("1109701001", var_4_36)
						arg_1_1:RecordAudio("1109701001", var_4_36)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701001", "story_v_side_new_1109701.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701001", "story_v_side_new_1109701.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_37 = var_4_28 + 0.3
			local var_4_38 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_28 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_37) / var_4_38

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1109701002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1109701002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1109701003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1019ui_story"]) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = arg_8_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1019ui_story"]) then
				if arg_8_1.var_.characterEffect1019ui_story and not isNil(arg_8_1.actors_["1019ui_story"]) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1019ui_story"]) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 0.325

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[950].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1109701002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 13 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 13)

				if (13 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 13)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1109701003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1109701003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1109701004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.925

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(1109701003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 37 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 37)

				if (37 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 37)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1109701004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1109701004
		arg_16_1.duration_ = 10.43

		local var_16_0 = {
			zh = 8.1,
			ja = 10.433
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
				arg_16_0:Play1109701005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = arg_16_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1019ui_story"].transform.position).z)
				arg_16_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1019ui_story"].transform.localEulerAngles = arg_16_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_16_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1019ui_story"].transform.position).z)
				arg_16_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1019ui_story"].transform.localEulerAngles = arg_16_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_19_1 = arg_16_1.actors_["1019ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 and not isNil(var_19_1) then
				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_1) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_19_4 = 0
			local var_19_5 = 0.725

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[949].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_6 = arg_16_1:GetWordFromCfg(1109701004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 29 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 29)

				if (29 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 29)) > 0 and var_19_5 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701004", "story_v_side_new_1109701.awb") ~= 0 then
					local var_19_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701004", "story_v_side_new_1109701.awb") / 1000

					if var_19_10 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_4
					end

					if var_19_6.prefab_name ~= "" and arg_16_1.actors_[var_19_6.prefab_name] ~= nil then
						local var_19_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_6.prefab_name].transform, "story_v_side_new_1109701", "1109701004", "story_v_side_new_1109701.awb")

						arg_16_1:RecordAudio("1109701004", var_19_11)
						arg_16_1:RecordAudio("1109701004", var_19_11)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701004", "story_v_side_new_1109701.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701004", "story_v_side_new_1109701.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_12 and arg_16_1.time_ < var_19_4 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play1109701005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1109701005
		arg_20_1.duration_ = 10.3

		local var_20_0 = {
			zh = 6.9,
			ja = 10.3
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
				arg_20_0:Play1109701006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_0 = 0
			local var_23_1 = 0.75

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[949].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(1109701005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 30 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 30)

				if (30 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 30)) > 0 and var_23_1 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701005", "story_v_side_new_1109701.awb") ~= 0 then
					local var_23_6 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701005", "story_v_side_new_1109701.awb") / 1000

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end

					if var_23_2.prefab_name ~= "" and arg_20_1.actors_[var_23_2.prefab_name] ~= nil then
						local var_23_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_2.prefab_name].transform, "story_v_side_new_1109701", "1109701005", "story_v_side_new_1109701.awb")

						arg_20_1:RecordAudio("1109701005", var_23_7)
						arg_20_1:RecordAudio("1109701005", var_23_7)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701005", "story_v_side_new_1109701.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701005", "story_v_side_new_1109701.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1109701006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1109701006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1109701007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = arg_24_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) then
				if arg_24_1.var_.characterEffect1019ui_story and not isNil(arg_24_1.actors_["1019ui_story"]) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.375

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[950].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(1109701006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 15 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 15)

				if (15 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 15)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1109701007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1109701007
		arg_28_1.duration_ = 7

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1109701008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.bgs_.ST01 == nil then
				local var_31_0 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_31_0.name = "ST01"
				var_31_0.transform.parent = arg_28_1.stage_.transform
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_.ST01 = var_31_0
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				local var_31_1 = arg_28_1.bgs_.ST01

				arg_28_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_31_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_2 = var_31_1:GetComponent("SpriteRenderer")

				if var_31_2 and var_31_2.sprite then
					local var_31_3 = 2 * (var_31_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_31_1.transform.localScale = Vector3.New(var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "ST01" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_4 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_5 = 2

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_5 then
				local var_31_6 = Color.New(1, 1, 1)

				var_31_6.a = Mathf.Lerp(1, 0, (arg_28_1.time_ - var_31_4) / var_31_5)
				arg_28_1.mask_.color = var_31_6
			end

			if arg_28_1.time_ >= var_31_4 + var_31_5 and arg_28_1.time_ < var_31_4 + var_31_5 + arg_31_0 then
				local var_31_7 = Color.New(1, 1, 1)

				arg_28_1.mask_.enabled = false
				var_31_7.a = 0
				arg_28_1.mask_.color = var_31_7
			end

			local var_31_8 = arg_28_1.actors_["1019ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_8.localPosition
			end

			local var_31_9 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_9 then
				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_9)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_9 and arg_28_1.time_ < 0 + var_31_9 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(0, 100, 0)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			local var_31_10 = arg_28_1.actors_["1019ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_10) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.034000001847744

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_11 and not isNil(var_31_10) then
				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_10) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_11)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_11 and arg_28_1.time_ < 0 + var_31_11 + arg_31_0 and not isNil(var_31_10) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_31_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_14 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_14

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_14
						arg_28_1.bgmTxt2_.text = var_31_14
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_28_1.time_ and arg_28_1.time_ <= 0.3 + arg_31_0 then
				arg_28_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_31_17 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_17 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_17

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_17
						arg_28_1.bgmTxt2_.text = var_31_17
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_18 = 2
			local var_31_19 = 0.425

			if 2 < arg_28_1.time_ and arg_28_1.time_ <= var_31_18 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_20 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_20:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_28_1.dialogCg_.alpha = arg_34_0
				end))
				var_31_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_21 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(1109701007).content)

				arg_28_1.text_.text = var_31_21

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_23 = 17 <= 0 and var_31_19 or var_31_19 * (utf8.len(var_31_21) / 17)

				if (17 <= 0 and var_31_19 or var_31_19 * (utf8.len(var_31_21) / 17)) > 0 and var_31_19 < var_31_23 then
					arg_28_1.talkMaxDuration = var_31_23
					var_31_18 = var_31_18 + 0.3

					if var_31_23 + var_31_18 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_18
					end
				end

				arg_28_1.text_.text = var_31_21
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_24 = var_31_18 + 0.3
			local var_31_25 = math.max(var_31_19, arg_28_1.talkMaxDuration)

			if var_31_18 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_24 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_24) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_24 + var_31_25 and arg_28_1.time_ < var_31_24 + var_31_25 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play1109701008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1109701008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1109701009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 1.1

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(1109701008).content)

				arg_36_1.text_.text = var_39_1

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_3 = 44 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 44)

				if (44 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 44)) > 0 and var_39_0 < var_39_3 then
					arg_36_1.talkMaxDuration = var_39_3

					if var_39_3 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_3 + 0
					end
				end

				arg_36_1.text_.text = var_39_1
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_4 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_4

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play1109701009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1109701009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1109701010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.5

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(1109701009).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 20 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 20)

				if (20 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 20)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1109701010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1109701010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1109701011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 1.25

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(1109701010).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 50 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 50)

				if (50 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 50)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1109701011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1109701011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1109701012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.975

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(1109701011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 39 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 39)

				if (39 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 39)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1109701012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1109701012
		arg_52_1.duration_ = 5.97

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1109701013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.bgs_.F01 == nil then
				local var_55_0 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01")
				var_55_0.name = "F01"
				var_55_0.transform.parent = arg_52_1.stage_.transform
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_.F01 = var_55_0
			end

			if 2 < arg_52_1.time_ and arg_52_1.time_ <= 2 + arg_55_0 then
				local var_55_1 = arg_52_1.bgs_.F01

				arg_52_1.bgs_.F01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_55_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_2 = var_55_1:GetComponent("SpriteRenderer")

				if var_55_2 and var_55_2.sprite then
					local var_55_3 = 2 * (var_55_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_55_1.transform.localScale = Vector3.New(var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "F01" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_4 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_5 = 2

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_5 then
				local var_55_6 = Color.New(0, 0, 0)

				var_55_6.a = Mathf.Lerp(0, 1, (arg_52_1.time_ - var_55_4) / var_55_5)
				arg_52_1.mask_.color = var_55_6
			end

			if arg_52_1.time_ >= var_55_4 + var_55_5 and arg_52_1.time_ < var_55_4 + var_55_5 + arg_55_0 then
				local var_55_7 = Color.New(0, 0, 0)

				var_55_7.a = 1
				arg_52_1.mask_.color = var_55_7
			end

			local var_55_8 = 2

			if 2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_9 = 2

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_9 then
				local var_55_10 = Color.New(0, 0, 0)

				var_55_10.a = Mathf.Lerp(1, 0, (arg_52_1.time_ - var_55_8) / var_55_9)
				arg_52_1.mask_.color = var_55_10
			end

			if arg_52_1.time_ >= var_55_8 + var_55_9 and arg_52_1.time_ < var_55_8 + var_55_9 + arg_55_0 then
				local var_55_11 = Color.New(0, 0, 0)

				arg_52_1.mask_.enabled = false
				var_55_11.a = 0
				arg_52_1.mask_.color = var_55_11
			end

			local var_55_12 = "1042ui_story"

			if arg_52_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_55_13 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_52_1.stage_.transform)

				var_55_13.name = var_55_12
				var_55_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_[var_55_12] = var_55_13

				local var_55_14 = var_55_13:GetComponentInChildren(typeof(CharacterEffect))

				var_55_14.enabled = true

				local var_55_15 = GameObjectTools.GetOrAddComponent(var_55_13, typeof(DynamicBoneHelper))

				if var_55_15 then
					var_55_15:EnableDynamicBone(false)
				end

				arg_52_1:ShowWeapon(var_55_14.transform, false)

				arg_52_1.var_[var_55_12 .. "Animator"] = var_55_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_52_1.var_[var_55_12 .. "Animator"].applyRootMotion = true
				arg_52_1.var_[var_55_12 .. "LipSync"] = var_55_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_55_16 = arg_52_1.actors_["1042ui_story"].transform

			if 3.8 < arg_52_1.time_ and arg_52_1.time_ <= 3.8 + arg_55_0 then
				arg_52_1.var_.moveOldPos1042ui_story = var_55_16.localPosition
			end

			local var_55_17 = 0.001

			if 3.8 <= arg_52_1.time_ and arg_52_1.time_ < 3.8 + var_55_17 then
				var_55_16.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_52_1.time_ - 3.8) / var_55_17)
				var_55_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_16.position).x, (manager.ui.mainCamera.transform.position - var_55_16.position).y, (manager.ui.mainCamera.transform.position - var_55_16.position).z)
				var_55_16.localEulerAngles.z = 0
				var_55_16.localEulerAngles.x = 0
				var_55_16.localEulerAngles = var_55_16.localEulerAngles
			end

			if arg_52_1.time_ >= 3.8 + var_55_17 and arg_52_1.time_ < 3.8 + var_55_17 + arg_55_0 then
				var_55_16.localPosition = Vector3.New(0, -1.06, -6.2)
				var_55_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_16.position).x, (manager.ui.mainCamera.transform.position - var_55_16.position).y, (manager.ui.mainCamera.transform.position - var_55_16.position).z)
				var_55_16.localEulerAngles.z = 0
				var_55_16.localEulerAngles.x = 0
				var_55_16.localEulerAngles = var_55_16.localEulerAngles
			end

			local var_55_18 = arg_52_1.actors_["1042ui_story"]

			if 3.8 < arg_52_1.time_ and arg_52_1.time_ <= 3.8 + arg_55_0 and not isNil(var_55_18) and arg_52_1.var_.characterEffect1042ui_story == nil then
				arg_52_1.var_.characterEffect1042ui_story = var_55_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_19 = 0.200000002980232

			if 3.8 <= arg_52_1.time_ and arg_52_1.time_ < 3.8 + var_55_19 and not isNil(var_55_18) then
				if arg_52_1.var_.characterEffect1042ui_story and not isNil(var_55_18) then
					arg_52_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 3.8 + var_55_19 and arg_52_1.time_ < 3.8 + var_55_19 + arg_55_0 and not isNil(var_55_18) and arg_52_1.var_.characterEffect1042ui_story then
				arg_52_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 3.8 < arg_52_1.time_ and arg_52_1.time_ <= 3.8 + arg_55_0 then
				arg_52_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			if 3.8 < arg_52_1.time_ and arg_52_1.time_ <= 3.8 + arg_55_0 then
				arg_52_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_21 = 4
			local var_55_22 = 0.075

			if 4 < arg_52_1.time_ and arg_52_1.time_ <= var_55_21 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_23 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_23:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_24 = arg_52_1:GetWordFromCfg(1109701012)
				local var_55_25 = arg_52_1:FormatText(var_55_24.content)

				arg_52_1.text_.text = var_55_25

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_27 = 3 <= 0 and var_55_22 or var_55_22 * (utf8.len(var_55_25) / 3)

				if (3 <= 0 and var_55_22 or var_55_22 * (utf8.len(var_55_25) / 3)) > 0 and var_55_22 < var_55_27 then
					arg_52_1.talkMaxDuration = var_55_27
					var_55_21 = var_55_21 + 0.3

					if var_55_27 + var_55_21 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_27 + var_55_21
					end
				end

				arg_52_1.text_.text = var_55_25
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701012", "story_v_side_new_1109701.awb") ~= 0 then
					local var_55_28 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701012", "story_v_side_new_1109701.awb") / 1000

					if var_55_28 + var_55_21 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_28 + var_55_21
					end

					if var_55_24.prefab_name ~= "" and arg_52_1.actors_[var_55_24.prefab_name] ~= nil then
						local var_55_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_24.prefab_name].transform, "story_v_side_new_1109701", "1109701012", "story_v_side_new_1109701.awb")

						arg_52_1:RecordAudio("1109701012", var_55_29)
						arg_52_1:RecordAudio("1109701012", var_55_29)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701012", "story_v_side_new_1109701.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701012", "story_v_side_new_1109701.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_30 = var_55_21 + 0.3
			local var_55_31 = math.max(var_55_22, arg_52_1.talkMaxDuration)

			if var_55_21 + 0.3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_30 + var_55_31 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_30) / var_55_31

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_30 + var_55_31 and arg_52_1.time_ < var_55_30 + var_55_31 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play1109701013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 1109701013
		arg_58_1.duration_ = 5.13

		local var_58_0 = {
			zh = 5.133,
			ja = 4.166
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play1109701014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1042ui_story = arg_58_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_61_0 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_58_1.time_ - 0) / var_61_0)
				arg_58_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1042ui_story"].transform.position).z)
				arg_58_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1042ui_story"].transform.localEulerAngles = arg_58_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1042ui_story"].transform.position).z)
				arg_58_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1042ui_story"].transform.localEulerAngles = arg_58_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_61_1 = arg_58_1.actors_["1042ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1042ui_story == nil then
				arg_58_1.var_.characterEffect1042ui_story = var_61_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_2 and not isNil(var_61_1) then
				if arg_58_1.var_.characterEffect1042ui_story and not isNil(var_61_1) then
					arg_58_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_2)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_2 and arg_58_1.time_ < 0 + var_61_2 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1042ui_story then
				arg_58_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_61_3 = "6045_story"

			if arg_58_1.actors_["6045_story"] == nil and not isNil((Asset.Load("Char/" .. "6045_story"))) then
				local var_61_4 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_58_1.stage_.transform)

				var_61_4.name = var_61_3
				var_61_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.actors_[var_61_3] = var_61_4

				local var_61_5 = var_61_4:GetComponentInChildren(typeof(CharacterEffect))

				var_61_5.enabled = true

				local var_61_6 = GameObjectTools.GetOrAddComponent(var_61_4, typeof(DynamicBoneHelper))

				if var_61_6 then
					var_61_6:EnableDynamicBone(false)
				end

				arg_58_1:ShowWeapon(var_61_5.transform, false)

				arg_58_1.var_[var_61_3 .. "Animator"] = var_61_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_58_1.var_[var_61_3 .. "Animator"].applyRootMotion = true
				arg_58_1.var_[var_61_3 .. "LipSync"] = var_61_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_61_7 = arg_58_1.actors_["6045_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos6045_story = var_61_7.localPosition

				local var_61_8 = GameObjectTools.GetOrAddComponent(var_61_7.gameObject, typeof(DynamicBoneHelper))

				if var_61_8 then
					var_61_8:EnableDynamicBone(false)
				end
			end

			local var_61_9 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_9 then
				var_61_7.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_58_1.time_ - 0) / var_61_9)
				var_61_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_7.position).x, (manager.ui.mainCamera.transform.position - var_61_7.position).y, (manager.ui.mainCamera.transform.position - var_61_7.position).z)
				var_61_7.localEulerAngles.z = 0
				var_61_7.localEulerAngles.x = 0
				var_61_7.localEulerAngles = var_61_7.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_9 and arg_58_1.time_ < 0 + var_61_9 + arg_61_0 then
				var_61_7.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_61_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_7.position).x, (manager.ui.mainCamera.transform.position - var_61_7.position).y, (manager.ui.mainCamera.transform.position - var_61_7.position).z)
				var_61_7.localEulerAngles.z = 0
				var_61_7.localEulerAngles.x = 0
				var_61_7.localEulerAngles = var_61_7.localEulerAngles

				local var_61_10 = GameObjectTools.GetOrAddComponent(var_61_7.gameObject, typeof(DynamicBoneHelper))

				if var_61_10 then
					var_61_10:EnableDynamicBone(true)
				end
			end

			local var_61_11 = arg_58_1.actors_["6045_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_11) and arg_58_1.var_.characterEffect6045_story == nil then
				arg_58_1.var_.characterEffect6045_story = var_61_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_12 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_12 and not isNil(var_61_11) then
				if arg_58_1.var_.characterEffect6045_story and not isNil(var_61_11) then
					arg_58_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_12 and arg_58_1.time_ < 0 + var_61_12 + arg_61_0 and not isNil(var_61_11) and arg_58_1.var_.characterEffect6045_story then
				arg_58_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_61_14 = "6046_story"

			if arg_58_1.actors_["6046_story"] == nil and not isNil((Asset.Load("Char/" .. "6046_story"))) then
				local var_61_15 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_58_1.stage_.transform)

				var_61_15.name = var_61_14
				var_61_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.actors_[var_61_14] = var_61_15

				local var_61_16 = var_61_15:GetComponentInChildren(typeof(CharacterEffect))

				var_61_16.enabled = true

				local var_61_17 = GameObjectTools.GetOrAddComponent(var_61_15, typeof(DynamicBoneHelper))

				if var_61_17 then
					var_61_17:EnableDynamicBone(false)
				end

				arg_58_1:ShowWeapon(var_61_16.transform, false)

				arg_58_1.var_[var_61_14 .. "Animator"] = var_61_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_58_1.var_[var_61_14 .. "Animator"].applyRootMotion = true
				arg_58_1.var_[var_61_14 .. "LipSync"] = var_61_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_61_18 = arg_58_1.actors_["6046_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos6046_story = var_61_18.localPosition

				local var_61_19 = GameObjectTools.GetOrAddComponent(var_61_18.gameObject, typeof(DynamicBoneHelper))

				if var_61_19 then
					var_61_19:EnableDynamicBone(false)
				end
			end

			local var_61_20 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_20 then
				var_61_18.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_58_1.time_ - 0) / var_61_20)
				var_61_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_18.position).x, (manager.ui.mainCamera.transform.position - var_61_18.position).y, (manager.ui.mainCamera.transform.position - var_61_18.position).z)
				var_61_18.localEulerAngles.z = 0
				var_61_18.localEulerAngles.x = 0
				var_61_18.localEulerAngles = var_61_18.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_20 and arg_58_1.time_ < 0 + var_61_20 + arg_61_0 then
				var_61_18.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_61_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_18.position).x, (manager.ui.mainCamera.transform.position - var_61_18.position).y, (manager.ui.mainCamera.transform.position - var_61_18.position).z)
				var_61_18.localEulerAngles.z = 0
				var_61_18.localEulerAngles.x = 0
				var_61_18.localEulerAngles = var_61_18.localEulerAngles

				local var_61_21 = GameObjectTools.GetOrAddComponent(var_61_18.gameObject, typeof(DynamicBoneHelper))

				if var_61_21 then
					var_61_21:EnableDynamicBone(true)
				end
			end

			local var_61_22 = arg_58_1.actors_["6046_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_22) and arg_58_1.var_.characterEffect6046_story == nil then
				arg_58_1.var_.characterEffect6046_story = var_61_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_23 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_23 and not isNil(var_61_22) then
				if arg_58_1.var_.characterEffect6046_story and not isNil(var_61_22) then
					arg_58_1.var_.characterEffect6046_story.fillFlat = true
					arg_58_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_23)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_23 and arg_58_1.time_ < 0 + var_61_23 + arg_61_0 and not isNil(var_61_22) and arg_58_1.var_.characterEffect6046_story then
				arg_58_1.var_.characterEffect6046_story.fillFlat = true
				arg_58_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_61_24 = 0
			local var_61_25 = 0.425

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_24 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_26 = arg_58_1:GetWordFromCfg(1109701013)
				local var_61_27 = arg_58_1:FormatText(var_61_26.content)

				arg_58_1.text_.text = var_61_27

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_29 = 17 <= 0 and var_61_25 or var_61_25 * (utf8.len(var_61_27) / 17)

				if (17 <= 0 and var_61_25 or var_61_25 * (utf8.len(var_61_27) / 17)) > 0 and var_61_25 < var_61_29 then
					arg_58_1.talkMaxDuration = var_61_29

					if var_61_29 + var_61_24 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_29 + var_61_24
					end
				end

				arg_58_1.text_.text = var_61_27
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701013", "story_v_side_new_1109701.awb") ~= 0 then
					local var_61_30 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701013", "story_v_side_new_1109701.awb") / 1000

					if var_61_30 + var_61_24 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_30 + var_61_24
					end

					if var_61_26.prefab_name ~= "" and arg_58_1.actors_[var_61_26.prefab_name] ~= nil then
						local var_61_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_26.prefab_name].transform, "story_v_side_new_1109701", "1109701013", "story_v_side_new_1109701.awb")

						arg_58_1:RecordAudio("1109701013", var_61_31)
						arg_58_1:RecordAudio("1109701013", var_61_31)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701013", "story_v_side_new_1109701.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701013", "story_v_side_new_1109701.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_32 = math.max(var_61_25, arg_58_1.talkMaxDuration)

			if var_61_24 <= arg_58_1.time_ and arg_58_1.time_ < var_61_24 + var_61_32 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_24) / var_61_32

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_24 + var_61_32 and arg_58_1.time_ < var_61_24 + var_61_32 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play1109701014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 1109701014
		arg_62_1.duration_ = 7.67

		local var_62_0 = {
			zh = 6.833,
			ja = 7.666
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play1109701015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos6045_story = arg_62_1.actors_["6045_story"].transform.localPosition

				local var_65_0 = GameObjectTools.GetOrAddComponent(arg_62_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_65_0 then
					var_65_0:EnableDynamicBone(false)
				end
			end

			local var_65_1 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_1 then
				arg_62_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_62_1.time_ - 0) / var_65_1)
				arg_62_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["6045_story"].transform.position).z)
				arg_62_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["6045_story"].transform.localEulerAngles = arg_62_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_1 and arg_62_1.time_ < 0 + var_65_1 + arg_65_0 then
				arg_62_1.actors_["6045_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_62_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["6045_story"].transform.position).z)
				arg_62_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["6045_story"].transform.localEulerAngles = arg_62_1.actors_["6045_story"].transform.localEulerAngles

				local var_65_2 = GameObjectTools.GetOrAddComponent(arg_62_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_65_2 then
					var_65_2:EnableDynamicBone(true)
				end
			end

			local var_65_3 = arg_62_1.actors_["6045_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_3) and arg_62_1.var_.characterEffect6045_story == nil then
				arg_62_1.var_.characterEffect6045_story = var_65_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_4 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 and not isNil(var_65_3) then
				if arg_62_1.var_.characterEffect6045_story and not isNil(var_65_3) then
					arg_62_1.var_.characterEffect6045_story.fillFlat = true
					arg_62_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_4)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 and not isNil(var_65_3) and arg_62_1.var_.characterEffect6045_story then
				arg_62_1.var_.characterEffect6045_story.fillFlat = true
				arg_62_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_65_5 = arg_62_1.actors_["6046_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos6046_story = var_65_5.localPosition

				local var_65_6 = GameObjectTools.GetOrAddComponent(var_65_5.gameObject, typeof(DynamicBoneHelper))

				if var_65_6 then
					var_65_6:EnableDynamicBone(false)
				end
			end

			local var_65_7 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				var_65_5.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_62_1.time_ - 0) / var_65_7)
				var_65_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_5.position).x, (manager.ui.mainCamera.transform.position - var_65_5.position).y, (manager.ui.mainCamera.transform.position - var_65_5.position).z)
				var_65_5.localEulerAngles.z = 0
				var_65_5.localEulerAngles.x = 0
				var_65_5.localEulerAngles = var_65_5.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				var_65_5.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_65_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_5.position).x, (manager.ui.mainCamera.transform.position - var_65_5.position).y, (manager.ui.mainCamera.transform.position - var_65_5.position).z)
				var_65_5.localEulerAngles.z = 0
				var_65_5.localEulerAngles.x = 0
				var_65_5.localEulerAngles = var_65_5.localEulerAngles

				local var_65_8 = GameObjectTools.GetOrAddComponent(var_65_5.gameObject, typeof(DynamicBoneHelper))

				if var_65_8 then
					var_65_8:EnableDynamicBone(true)
				end
			end

			local var_65_9 = arg_62_1.actors_["6046_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect6046_story == nil then
				arg_62_1.var_.characterEffect6046_story = var_65_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_10 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_10 and not isNil(var_65_9) then
				if arg_62_1.var_.characterEffect6046_story and not isNil(var_65_9) then
					arg_62_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_10 and arg_62_1.time_ < 0 + var_65_10 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect6046_story then
				arg_62_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_65_12 = 0
			local var_65_13 = 0.675

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_12 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_14 = arg_62_1:GetWordFromCfg(1109701014)
				local var_65_15 = arg_62_1:FormatText(var_65_14.content)

				arg_62_1.text_.text = var_65_15

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_17 = 27 <= 0 and var_65_13 or var_65_13 * (utf8.len(var_65_15) / 27)

				if (27 <= 0 and var_65_13 or var_65_13 * (utf8.len(var_65_15) / 27)) > 0 and var_65_13 < var_65_17 then
					arg_62_1.talkMaxDuration = var_65_17

					if var_65_17 + var_65_12 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_17 + var_65_12
					end
				end

				arg_62_1.text_.text = var_65_15
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701014", "story_v_side_new_1109701.awb") ~= 0 then
					local var_65_18 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701014", "story_v_side_new_1109701.awb") / 1000

					if var_65_18 + var_65_12 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_18 + var_65_12
					end

					if var_65_14.prefab_name ~= "" and arg_62_1.actors_[var_65_14.prefab_name] ~= nil then
						local var_65_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_14.prefab_name].transform, "story_v_side_new_1109701", "1109701014", "story_v_side_new_1109701.awb")

						arg_62_1:RecordAudio("1109701014", var_65_19)
						arg_62_1:RecordAudio("1109701014", var_65_19)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701014", "story_v_side_new_1109701.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701014", "story_v_side_new_1109701.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_20 = math.max(var_65_13, arg_62_1.talkMaxDuration)

			if var_65_12 <= arg_62_1.time_ and arg_62_1.time_ < var_65_12 + var_65_20 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_12) / var_65_20

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_12 + var_65_20 and arg_62_1.time_ < var_65_12 + var_65_20 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play1109701015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 1109701015
		arg_66_1.duration_ = 3.7

		local var_66_0 = {
			zh = 3.7,
			ja = 2.366
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play1109701016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if arg_66_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_69_0 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_66_1.stage_.transform)

				var_69_0.name = "1097ui_story"
				var_69_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_["1097ui_story"] = var_69_0

				local var_69_1 = var_69_0:GetComponentInChildren(typeof(CharacterEffect))

				var_69_1.enabled = true

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_0, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end

				arg_66_1:ShowWeapon(var_69_1.transform, false)

				arg_66_1.var_["1097ui_story" .. "Animator"] = var_69_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_66_1.var_["1097ui_story" .. "Animator"].applyRootMotion = true
				arg_66_1.var_["1097ui_story" .. "LipSync"] = var_69_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_69_3 = arg_66_1.actors_["1097ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1097ui_story = var_69_3.localPosition
			end

			local var_69_4 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				var_69_3.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_66_1.time_ - 0) / var_69_4)
				var_69_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_3.position).x, (manager.ui.mainCamera.transform.position - var_69_3.position).y, (manager.ui.mainCamera.transform.position - var_69_3.position).z)
				var_69_3.localEulerAngles.z = 0
				var_69_3.localEulerAngles.x = 0
				var_69_3.localEulerAngles = var_69_3.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				var_69_3.localPosition = Vector3.New(0, -0.54, -6.3)
				var_69_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_3.position).x, (manager.ui.mainCamera.transform.position - var_69_3.position).y, (manager.ui.mainCamera.transform.position - var_69_3.position).z)
				var_69_3.localEulerAngles.z = 0
				var_69_3.localEulerAngles.x = 0
				var_69_3.localEulerAngles = var_69_3.localEulerAngles
			end

			local var_69_5 = arg_66_1.actors_["1097ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1097ui_story == nil then
				arg_66_1.var_.characterEffect1097ui_story = var_69_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_6 and not isNil(var_69_5) then
				if arg_66_1.var_.characterEffect1097ui_story and not isNil(var_69_5) then
					arg_66_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_6 and arg_66_1.time_ < 0 + var_69_6 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1097ui_story then
				arg_66_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_69_8 = arg_66_1.actors_["6045_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos6045_story = var_69_8.localPosition

				local var_69_9 = GameObjectTools.GetOrAddComponent(var_69_8.gameObject, typeof(DynamicBoneHelper))

				if var_69_9 then
					var_69_9:EnableDynamicBone(false)
				end
			end

			local var_69_10 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_10 then
				var_69_8.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_10)
				var_69_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_8.position).x, (manager.ui.mainCamera.transform.position - var_69_8.position).y, (manager.ui.mainCamera.transform.position - var_69_8.position).z)
				var_69_8.localEulerAngles.z = 0
				var_69_8.localEulerAngles.x = 0
				var_69_8.localEulerAngles = var_69_8.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_10 and arg_66_1.time_ < 0 + var_69_10 + arg_69_0 then
				var_69_8.localPosition = Vector3.New(0, 100, 0)
				var_69_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_8.position).x, (manager.ui.mainCamera.transform.position - var_69_8.position).y, (manager.ui.mainCamera.transform.position - var_69_8.position).z)
				var_69_8.localEulerAngles.z = 0
				var_69_8.localEulerAngles.x = 0
				var_69_8.localEulerAngles = var_69_8.localEulerAngles

				local var_69_11 = GameObjectTools.GetOrAddComponent(var_69_8.gameObject, typeof(DynamicBoneHelper))

				if var_69_11 then
					var_69_11:EnableDynamicBone(true)
				end
			end

			local var_69_12 = arg_66_1.actors_["6045_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_12) and arg_66_1.var_.characterEffect6045_story == nil then
				arg_66_1.var_.characterEffect6045_story = var_69_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_13 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_13 and not isNil(var_69_12) then
				if arg_66_1.var_.characterEffect6045_story and not isNil(var_69_12) then
					arg_66_1.var_.characterEffect6045_story.fillFlat = true
					arg_66_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_13)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_13 and arg_66_1.time_ < 0 + var_69_13 + arg_69_0 and not isNil(var_69_12) and arg_66_1.var_.characterEffect6045_story then
				arg_66_1.var_.characterEffect6045_story.fillFlat = true
				arg_66_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_69_14 = arg_66_1.actors_["6046_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos6046_story = var_69_14.localPosition

				local var_69_15 = GameObjectTools.GetOrAddComponent(var_69_14.gameObject, typeof(DynamicBoneHelper))

				if var_69_15 then
					var_69_15:EnableDynamicBone(false)
				end
			end

			local var_69_16 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_16 then
				var_69_14.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_16)
				var_69_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_14.position).x, (manager.ui.mainCamera.transform.position - var_69_14.position).y, (manager.ui.mainCamera.transform.position - var_69_14.position).z)
				var_69_14.localEulerAngles.z = 0
				var_69_14.localEulerAngles.x = 0
				var_69_14.localEulerAngles = var_69_14.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_16 and arg_66_1.time_ < 0 + var_69_16 + arg_69_0 then
				var_69_14.localPosition = Vector3.New(0, 100, 0)
				var_69_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_14.position).x, (manager.ui.mainCamera.transform.position - var_69_14.position).y, (manager.ui.mainCamera.transform.position - var_69_14.position).z)
				var_69_14.localEulerAngles.z = 0
				var_69_14.localEulerAngles.x = 0
				var_69_14.localEulerAngles = var_69_14.localEulerAngles

				local var_69_17 = GameObjectTools.GetOrAddComponent(var_69_14.gameObject, typeof(DynamicBoneHelper))

				if var_69_17 then
					var_69_17:EnableDynamicBone(true)
				end
			end

			local var_69_18 = arg_66_1.actors_["6046_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_18) and arg_66_1.var_.characterEffect6046_story == nil then
				arg_66_1.var_.characterEffect6046_story = var_69_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_19 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_19 and not isNil(var_69_18) then
				if arg_66_1.var_.characterEffect6046_story and not isNil(var_69_18) then
					arg_66_1.var_.characterEffect6046_story.fillFlat = true
					arg_66_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_19)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_19 and arg_66_1.time_ < 0 + var_69_19 + arg_69_0 and not isNil(var_69_18) and arg_66_1.var_.characterEffect6046_story then
				arg_66_1.var_.characterEffect6046_story.fillFlat = true
				arg_66_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_69_20 = 0
			local var_69_21 = 0.5

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_20 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_22 = arg_66_1:GetWordFromCfg(1109701015)
				local var_69_23 = arg_66_1:FormatText(var_69_22.content)

				arg_66_1.text_.text = var_69_23

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_25 = 20 <= 0 and var_69_21 or var_69_21 * (utf8.len(var_69_23) / 20)

				if (20 <= 0 and var_69_21 or var_69_21 * (utf8.len(var_69_23) / 20)) > 0 and var_69_21 < var_69_25 then
					arg_66_1.talkMaxDuration = var_69_25

					if var_69_25 + var_69_20 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_25 + var_69_20
					end
				end

				arg_66_1.text_.text = var_69_23
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701015", "story_v_side_new_1109701.awb") ~= 0 then
					local var_69_26 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701015", "story_v_side_new_1109701.awb") / 1000

					if var_69_26 + var_69_20 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_26 + var_69_20
					end

					if var_69_22.prefab_name ~= "" and arg_66_1.actors_[var_69_22.prefab_name] ~= nil then
						local var_69_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_22.prefab_name].transform, "story_v_side_new_1109701", "1109701015", "story_v_side_new_1109701.awb")

						arg_66_1:RecordAudio("1109701015", var_69_27)
						arg_66_1:RecordAudio("1109701015", var_69_27)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701015", "story_v_side_new_1109701.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701015", "story_v_side_new_1109701.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_28 = math.max(var_69_21, arg_66_1.talkMaxDuration)

			if var_69_20 <= arg_66_1.time_ and arg_66_1.time_ < var_69_20 + var_69_28 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_20) / var_69_28

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_20 + var_69_28 and arg_66_1.time_ < var_69_20 + var_69_28 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play1109701016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 1109701016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play1109701017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1097ui_story"]) and arg_70_1.var_.characterEffect1097ui_story == nil then
				arg_70_1.var_.characterEffect1097ui_story = arg_70_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1097ui_story"]) then
				if arg_70_1.var_.characterEffect1097ui_story and not isNil(arg_70_1.actors_["1097ui_story"]) then
					arg_70_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1097ui_story"]) and arg_70_1.var_.characterEffect1097ui_story then
				arg_70_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_73_1 = arg_70_1.actors_["1097ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1097ui_story = var_73_1.localPosition
			end

			local var_73_2 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_2 then
				var_73_1.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_2)
				var_73_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_1.position).x, (manager.ui.mainCamera.transform.position - var_73_1.position).y, (manager.ui.mainCamera.transform.position - var_73_1.position).z)
				var_73_1.localEulerAngles.z = 0
				var_73_1.localEulerAngles.x = 0
				var_73_1.localEulerAngles = var_73_1.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_2 and arg_70_1.time_ < 0 + var_73_2 + arg_73_0 then
				var_73_1.localPosition = Vector3.New(0, 100, 0)
				var_73_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_1.position).x, (manager.ui.mainCamera.transform.position - var_73_1.position).y, (manager.ui.mainCamera.transform.position - var_73_1.position).z)
				var_73_1.localEulerAngles.z = 0
				var_73_1.localEulerAngles.x = 0
				var_73_1.localEulerAngles = var_73_1.localEulerAngles
			end

			local var_73_3 = 0
			local var_73_4 = 0.975

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_3 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_5 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(1109701016).content)

				arg_70_1.text_.text = var_73_5

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_7 = 39 <= 0 and var_73_4 or var_73_4 * (utf8.len(var_73_5) / 39)

				if (39 <= 0 and var_73_4 or var_73_4 * (utf8.len(var_73_5) / 39)) > 0 and var_73_4 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_3 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_3
					end
				end

				arg_70_1.text_.text = var_73_5
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_8 = math.max(var_73_4, arg_70_1.talkMaxDuration)

			if var_73_3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_3 + var_73_8 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_3) / var_73_8

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_3 + var_73_8 and arg_70_1.time_ < var_73_3 + var_73_8 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play1109701017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 1109701017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play1109701018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.925

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(1109701017).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 37 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 37)

				if (37 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 37)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play1109701018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 1109701018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play1109701019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.725

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(1109701018).content)

				arg_78_1.text_.text = var_81_1

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_3 = 29 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 29)

				if (29 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 29)) > 0 and var_81_0 < var_81_3 then
					arg_78_1.talkMaxDuration = var_81_3

					if var_81_3 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_3 + 0
					end
				end

				arg_78_1.text_.text = var_81_1
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_4 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_4

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play1109701019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 1109701019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play1109701020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.325

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(1109701019).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 13 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 13)

				if (13 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 13)) > 0 and var_85_0 < var_85_3 then
					arg_82_1.talkMaxDuration = var_85_3

					if var_85_3 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_3 + 0
					end
				end

				arg_82_1.text_.text = var_85_1
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_4 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_4

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play1109701020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 1109701020
		arg_86_1.duration_ = 3.73

		local var_86_0 = {
			zh = 3.133,
			ja = 3.733
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
				arg_86_0:Play1109701021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1042ui_story = arg_86_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1042ui_story"].transform.position).z)
				arg_86_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1042ui_story"].transform.localEulerAngles = arg_86_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_86_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1042ui_story"].transform.position).z)
				arg_86_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1042ui_story"].transform.localEulerAngles = arg_86_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["1042ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect1042ui_story == nil then
				arg_86_1.var_.characterEffect1042ui_story = var_89_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 and not isNil(var_89_1) then
				if arg_86_1.var_.characterEffect1042ui_story and not isNil(var_89_1) then
					arg_86_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect1042ui_story then
				arg_86_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_89_4 = 0
			local var_89_5 = 0.575

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(1109701020)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 23 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 23)

				if (23 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 23)) > 0 and var_89_5 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701020", "story_v_side_new_1109701.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701020", "story_v_side_new_1109701.awb") / 1000

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end

					if var_89_6.prefab_name ~= "" and arg_86_1.actors_[var_89_6.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_6.prefab_name].transform, "story_v_side_new_1109701", "1109701020", "story_v_side_new_1109701.awb")

						arg_86_1:RecordAudio("1109701020", var_89_11)
						arg_86_1:RecordAudio("1109701020", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701020", "story_v_side_new_1109701.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701020", "story_v_side_new_1109701.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_12 and arg_86_1.time_ < var_89_4 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play1109701021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1109701021
		arg_90_1.duration_ = 16.4

		local var_90_0 = {
			zh = 11.633,
			ja = 16.4
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
				arg_90_0:Play1109701022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1042ui_story = arg_90_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_93_0 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 then
				arg_90_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_90_1.time_ - 0) / var_93_0)
				arg_90_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1042ui_story"].transform.position).z)
				arg_90_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["1042ui_story"].transform.localEulerAngles = arg_90_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 then
				arg_90_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_90_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1042ui_story"].transform.position).z)
				arg_90_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["1042ui_story"].transform.localEulerAngles = arg_90_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_93_1 = arg_90_1.actors_["1042ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect1042ui_story == nil then
				arg_90_1.var_.characterEffect1042ui_story = var_93_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_2 and not isNil(var_93_1) then
				if arg_90_1.var_.characterEffect1042ui_story and not isNil(var_93_1) then
					arg_90_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_2 and arg_90_1.time_ < 0 + var_93_2 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect1042ui_story then
				arg_90_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action426")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_93_4 = 0
			local var_93_5 = 1.525

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(1109701021)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 61 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 61)

				if (61 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 61)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701021", "story_v_side_new_1109701.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701021", "story_v_side_new_1109701.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_side_new_1109701", "1109701021", "story_v_side_new_1109701.awb")

						arg_90_1:RecordAudio("1109701021", var_93_11)
						arg_90_1:RecordAudio("1109701021", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701021", "story_v_side_new_1109701.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701021", "story_v_side_new_1109701.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_12 and arg_90_1.time_ < var_93_4 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play1109701022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1109701022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play1109701023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1042ui_story"]) and arg_94_1.var_.characterEffect1042ui_story == nil then
				arg_94_1.var_.characterEffect1042ui_story = arg_94_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1042ui_story"]) then
				if arg_94_1.var_.characterEffect1042ui_story and not isNil(arg_94_1.actors_["1042ui_story"]) then
					arg_94_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_0)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1042ui_story"]) and arg_94_1.var_.characterEffect1042ui_story then
				arg_94_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_97_1 = 0
			local var_97_2 = 0.1

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(1109701022).content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 4 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_3) / 4)

				if (4 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_3) / 4)) > 0 and var_97_2 < var_97_5 then
					arg_94_1.talkMaxDuration = var_97_5

					if var_97_5 + var_97_1 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + var_97_1
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_6 = math.max(var_97_2, arg_94_1.talkMaxDuration)

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_6 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_1) / var_97_6

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_1 + var_97_6 and arg_94_1.time_ < var_97_1 + var_97_6 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play1109701023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1109701023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1109701024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1042ui_story = arg_98_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_101_0 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 then
				arg_98_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_0)
				arg_98_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1042ui_story"].transform.position).z)
				arg_98_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1042ui_story"].transform.localEulerAngles = arg_98_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 then
				arg_98_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1042ui_story"].transform.position).z)
				arg_98_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1042ui_story"].transform.localEulerAngles = arg_98_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_101_1 = arg_98_1.actors_["1042ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect1042ui_story == nil then
				arg_98_1.var_.characterEffect1042ui_story = var_101_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_2 and not isNil(var_101_1) then
				if arg_98_1.var_.characterEffect1042ui_story and not isNil(var_101_1) then
					arg_98_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_2)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_2 and arg_98_1.time_ < 0 + var_101_2 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect1042ui_story then
				arg_98_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_101_3 = 0
			local var_101_4 = 1.3

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_3 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_5 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(1109701023).content)

				arg_98_1.text_.text = var_101_5

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_7 = 52 <= 0 and var_101_4 or var_101_4 * (utf8.len(var_101_5) / 52)

				if (52 <= 0 and var_101_4 or var_101_4 * (utf8.len(var_101_5) / 52)) > 0 and var_101_4 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_3 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_3
					end
				end

				arg_98_1.text_.text = var_101_5
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_4, arg_98_1.talkMaxDuration)

			if var_101_3 <= arg_98_1.time_ and arg_98_1.time_ < var_101_3 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_3) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_3 + var_101_8 and arg_98_1.time_ < var_101_3 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play1109701024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 1109701024
		arg_102_1.duration_ = 4.1

		local var_102_0 = {
			zh = 4.1,
			ja = 3.466
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
				arg_102_0:Play1109701025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1097ui_story = arg_102_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1097ui_story"].transform.position).z)
				arg_102_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1097ui_story"].transform.localEulerAngles = arg_102_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_102_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1097ui_story"].transform.position).z)
				arg_102_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1097ui_story"].transform.localEulerAngles = arg_102_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["1097ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1097ui_story == nil then
				arg_102_1.var_.characterEffect1097ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect1097ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1097ui_story then
				arg_102_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_105_4 = 0
			local var_105_5 = 0.275

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(1109701024)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 11 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 11)

				if (11 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 11)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701024", "story_v_side_new_1109701.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701024", "story_v_side_new_1109701.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_side_new_1109701", "1109701024", "story_v_side_new_1109701.awb")

						arg_102_1:RecordAudio("1109701024", var_105_11)
						arg_102_1:RecordAudio("1109701024", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701024", "story_v_side_new_1109701.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701024", "story_v_side_new_1109701.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play1109701025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1109701025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play1109701026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1097ui_story"]) and arg_106_1.var_.characterEffect1097ui_story == nil then
				arg_106_1.var_.characterEffect1097ui_story = arg_106_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1097ui_story"]) then
				if arg_106_1.var_.characterEffect1097ui_story and not isNil(arg_106_1.actors_["1097ui_story"]) then
					arg_106_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_0)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1097ui_story"]) and arg_106_1.var_.characterEffect1097ui_story then
				arg_106_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_109_1 = 0
			local var_109_2 = 1.225

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(1109701025).content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 49 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 49)

				if (49 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 49)) > 0 and var_109_2 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_6 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_6 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_6

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_6 and arg_106_1.time_ < var_109_1 + var_109_6 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play1109701026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1109701026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1109701027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.525

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(1109701026).content)

				arg_110_1.text_.text = var_113_1

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_3 = 21 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 21)

				if (21 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 21)) > 0 and var_113_0 < var_113_3 then
					arg_110_1.talkMaxDuration = var_113_3

					if var_113_3 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_3 + 0
					end
				end

				arg_110_1.text_.text = var_113_1
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_4 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_4

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play1109701027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1109701027
		arg_114_1.duration_ = 9.87

		local var_114_0 = {
			zh = 9.866,
			ja = 8.233
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
				arg_114_0:Play1109701028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1097ui_story = arg_114_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_117_0 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 then
				arg_114_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_114_1.time_ - 0) / var_117_0)
				arg_114_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1097ui_story"].transform.position).z)
				arg_114_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1097ui_story"].transform.localEulerAngles = arg_114_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 then
				arg_114_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_114_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1097ui_story"].transform.position).z)
				arg_114_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1097ui_story"].transform.localEulerAngles = arg_114_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_117_1 = arg_114_1.actors_["1097ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect1097ui_story == nil then
				arg_114_1.var_.characterEffect1097ui_story = var_117_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_2 and not isNil(var_117_1) then
				if arg_114_1.var_.characterEffect1097ui_story and not isNil(var_117_1) then
					arg_114_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_2 and arg_114_1.time_ < 0 + var_117_2 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect1097ui_story then
				arg_114_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_117_4 = 0
			local var_117_5 = 0.675

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(1109701027)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 27 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 27)

				if (27 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 27)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701027", "story_v_side_new_1109701.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701027", "story_v_side_new_1109701.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_side_new_1109701", "1109701027", "story_v_side_new_1109701.awb")

						arg_114_1:RecordAudio("1109701027", var_117_11)
						arg_114_1:RecordAudio("1109701027", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701027", "story_v_side_new_1109701.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701027", "story_v_side_new_1109701.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play1109701028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1109701028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1109701029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1097ui_story"]) and arg_118_1.var_.characterEffect1097ui_story == nil then
				arg_118_1.var_.characterEffect1097ui_story = arg_118_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1097ui_story"]) then
				if arg_118_1.var_.characterEffect1097ui_story and not isNil(arg_118_1.actors_["1097ui_story"]) then
					arg_118_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1097ui_story"]) and arg_118_1.var_.characterEffect1097ui_story then
				arg_118_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_121_1 = 0
			local var_121_2 = 0.4

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(1109701028).content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 16 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 16)

				if (16 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 16)) > 0 and var_121_2 < var_121_5 then
					arg_118_1.talkMaxDuration = var_121_5

					if var_121_5 + var_121_1 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + var_121_1
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_6 = math.max(var_121_2, arg_118_1.talkMaxDuration)

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_6 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_1) / var_121_6

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_1 + var_121_6 and arg_118_1.time_ < var_121_1 + var_121_6 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play1109701029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1109701029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1109701030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.775

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(1109701029).content)

				arg_122_1.text_.text = var_125_1

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_3 = 31 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 31)

				if (31 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 31)) > 0 and var_125_0 < var_125_3 then
					arg_122_1.talkMaxDuration = var_125_3

					if var_125_3 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_3 + 0
					end
				end

				arg_122_1.text_.text = var_125_1
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_4 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_4

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play1109701030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1109701030
		arg_126_1.duration_ = 4.97

		local var_126_0 = {
			zh = 2.133,
			ja = 4.966
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1109701031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1097ui_story = arg_126_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1097ui_story"].transform.position).z)
				arg_126_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1097ui_story"].transform.localEulerAngles = arg_126_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_126_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1097ui_story"].transform.position).z)
				arg_126_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1097ui_story"].transform.localEulerAngles = arg_126_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_129_1 = arg_126_1.actors_["1097ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1097ui_story == nil then
				arg_126_1.var_.characterEffect1097ui_story = var_129_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 and not isNil(var_129_1) then
				if arg_126_1.var_.characterEffect1097ui_story and not isNil(var_129_1) then
					arg_126_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1097ui_story then
				arg_126_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_129_4 = 0
			local var_129_5 = 0.125

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_6 = arg_126_1:GetWordFromCfg(1109701030)
				local var_129_7 = arg_126_1:FormatText(var_129_6.content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_9 = 5 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 5)

				if (5 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 5)) > 0 and var_129_5 < var_129_9 then
					arg_126_1.talkMaxDuration = var_129_9

					if var_129_9 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_4
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701030", "story_v_side_new_1109701.awb") ~= 0 then
					local var_129_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701030", "story_v_side_new_1109701.awb") / 1000

					if var_129_10 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_4
					end

					if var_129_6.prefab_name ~= "" and arg_126_1.actors_[var_129_6.prefab_name] ~= nil then
						local var_129_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_6.prefab_name].transform, "story_v_side_new_1109701", "1109701030", "story_v_side_new_1109701.awb")

						arg_126_1:RecordAudio("1109701030", var_129_11)
						arg_126_1:RecordAudio("1109701030", var_129_11)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701030", "story_v_side_new_1109701.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701030", "story_v_side_new_1109701.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_12 = math.max(var_129_5, arg_126_1.talkMaxDuration)

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_12 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_4) / var_129_12

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_4 + var_129_12 and arg_126_1.time_ < var_129_4 + var_129_12 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play1109701031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1109701031
		arg_130_1.duration_ = 6.43

		local var_130_0 = {
			zh = 5.2,
			ja = 6.433
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1109701032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_133_0 = 0
			local var_133_1 = 0.4

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(1109701031)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 16 <= 0 and var_133_1 or var_133_1 * (utf8.len(var_133_3) / 16)

				if (16 <= 0 and var_133_1 or var_133_1 * (utf8.len(var_133_3) / 16)) > 0 and var_133_1 < var_133_5 then
					arg_130_1.talkMaxDuration = var_133_5

					if var_133_5 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701031", "story_v_side_new_1109701.awb") ~= 0 then
					local var_133_6 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701031", "story_v_side_new_1109701.awb") / 1000

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end

					if var_133_2.prefab_name ~= "" and arg_130_1.actors_[var_133_2.prefab_name] ~= nil then
						local var_133_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_2.prefab_name].transform, "story_v_side_new_1109701", "1109701031", "story_v_side_new_1109701.awb")

						arg_130_1:RecordAudio("1109701031", var_133_7)
						arg_130_1:RecordAudio("1109701031", var_133_7)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701031", "story_v_side_new_1109701.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701031", "story_v_side_new_1109701.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_8 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_8 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_8

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_8 and arg_130_1.time_ < var_133_0 + var_133_8 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play1109701032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1109701032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1109701033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1097ui_story"]) and arg_134_1.var_.characterEffect1097ui_story == nil then
				arg_134_1.var_.characterEffect1097ui_story = arg_134_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1097ui_story"]) then
				if arg_134_1.var_.characterEffect1097ui_story and not isNil(arg_134_1.actors_["1097ui_story"]) then
					arg_134_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1097ui_story"]) and arg_134_1.var_.characterEffect1097ui_story then
				arg_134_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_137_1 = 0
			local var_137_2 = 0.05

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(1109701032).content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 2 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 2)

				if (2 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 2)) > 0 and var_137_2 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_6 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_6 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_6

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_6 and arg_134_1.time_ < var_137_1 + var_137_6 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1109701033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1109701033
		arg_138_1.duration_ = 9.7

		local var_138_0 = {
			zh = 9.7,
			ja = 7.233
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1109701034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1097ui_story = arg_138_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1097ui_story"].transform.position).z)
				arg_138_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1097ui_story"].transform.localEulerAngles = arg_138_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_138_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1097ui_story"].transform.position).z)
				arg_138_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1097ui_story"].transform.localEulerAngles = arg_138_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_141_1 = arg_138_1.actors_["1097ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1097ui_story == nil then
				arg_138_1.var_.characterEffect1097ui_story = var_141_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 and not isNil(var_141_1) then
				if arg_138_1.var_.characterEffect1097ui_story and not isNil(var_141_1) then
					arg_138_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_2)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1097ui_story then
				arg_138_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_141_3 = arg_138_1.actors_["6045_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos6045_story = var_141_3.localPosition

				local var_141_4 = GameObjectTools.GetOrAddComponent(var_141_3.gameObject, typeof(DynamicBoneHelper))

				if var_141_4 then
					var_141_4:EnableDynamicBone(false)
				end
			end

			local var_141_5 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_5 then
				var_141_3.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_138_1.time_ - 0) / var_141_5)
				var_141_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_3.position).x, (manager.ui.mainCamera.transform.position - var_141_3.position).y, (manager.ui.mainCamera.transform.position - var_141_3.position).z)
				var_141_3.localEulerAngles.z = 0
				var_141_3.localEulerAngles.x = 0
				var_141_3.localEulerAngles = var_141_3.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_5 and arg_138_1.time_ < 0 + var_141_5 + arg_141_0 then
				var_141_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_141_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_3.position).x, (manager.ui.mainCamera.transform.position - var_141_3.position).y, (manager.ui.mainCamera.transform.position - var_141_3.position).z)
				var_141_3.localEulerAngles.z = 0
				var_141_3.localEulerAngles.x = 0
				var_141_3.localEulerAngles = var_141_3.localEulerAngles

				local var_141_6 = GameObjectTools.GetOrAddComponent(var_141_3.gameObject, typeof(DynamicBoneHelper))

				if var_141_6 then
					var_141_6:EnableDynamicBone(true)
				end
			end

			local var_141_7 = arg_138_1.actors_["6045_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_7) and arg_138_1.var_.characterEffect6045_story == nil then
				arg_138_1.var_.characterEffect6045_story = var_141_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_8 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_8 and not isNil(var_141_7) then
				if arg_138_1.var_.characterEffect6045_story and not isNil(var_141_7) then
					arg_138_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_8 and arg_138_1.time_ < 0 + var_141_8 + arg_141_0 and not isNil(var_141_7) and arg_138_1.var_.characterEffect6045_story then
				arg_138_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_141_10 = arg_138_1.actors_["6046_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos6046_story = var_141_10.localPosition

				local var_141_11 = GameObjectTools.GetOrAddComponent(var_141_10.gameObject, typeof(DynamicBoneHelper))

				if var_141_11 then
					var_141_11:EnableDynamicBone(false)
				end
			end

			local var_141_12 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_12 then
				var_141_10.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_138_1.time_ - 0) / var_141_12)
				var_141_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_10.position).x, (manager.ui.mainCamera.transform.position - var_141_10.position).y, (manager.ui.mainCamera.transform.position - var_141_10.position).z)
				var_141_10.localEulerAngles.z = 0
				var_141_10.localEulerAngles.x = 0
				var_141_10.localEulerAngles = var_141_10.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_12 and arg_138_1.time_ < 0 + var_141_12 + arg_141_0 then
				var_141_10.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_141_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_10.position).x, (manager.ui.mainCamera.transform.position - var_141_10.position).y, (manager.ui.mainCamera.transform.position - var_141_10.position).z)
				var_141_10.localEulerAngles.z = 0
				var_141_10.localEulerAngles.x = 0
				var_141_10.localEulerAngles = var_141_10.localEulerAngles

				local var_141_13 = GameObjectTools.GetOrAddComponent(var_141_10.gameObject, typeof(DynamicBoneHelper))

				if var_141_13 then
					var_141_13:EnableDynamicBone(true)
				end
			end

			local var_141_14 = arg_138_1.actors_["6046_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_14) and arg_138_1.var_.characterEffect6046_story == nil then
				arg_138_1.var_.characterEffect6046_story = var_141_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_15 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_15 and not isNil(var_141_14) then
				if arg_138_1.var_.characterEffect6046_story and not isNil(var_141_14) then
					arg_138_1.var_.characterEffect6046_story.fillFlat = true
					arg_138_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_15)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_15 and arg_138_1.time_ < 0 + var_141_15 + arg_141_0 and not isNil(var_141_14) and arg_138_1.var_.characterEffect6046_story then
				arg_138_1.var_.characterEffect6046_story.fillFlat = true
				arg_138_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_141_16 = 0
			local var_141_17 = 0.825

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_16 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_18 = arg_138_1:GetWordFromCfg(1109701033)
				local var_141_19 = arg_138_1:FormatText(var_141_18.content)

				arg_138_1.text_.text = var_141_19

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_21 = 33 <= 0 and var_141_17 or var_141_17 * (utf8.len(var_141_19) / 33)

				if (33 <= 0 and var_141_17 or var_141_17 * (utf8.len(var_141_19) / 33)) > 0 and var_141_17 < var_141_21 then
					arg_138_1.talkMaxDuration = var_141_21

					if var_141_21 + var_141_16 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_21 + var_141_16
					end
				end

				arg_138_1.text_.text = var_141_19
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701033", "story_v_side_new_1109701.awb") ~= 0 then
					local var_141_22 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701033", "story_v_side_new_1109701.awb") / 1000

					if var_141_22 + var_141_16 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_22 + var_141_16
					end

					if var_141_18.prefab_name ~= "" and arg_138_1.actors_[var_141_18.prefab_name] ~= nil then
						local var_141_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_18.prefab_name].transform, "story_v_side_new_1109701", "1109701033", "story_v_side_new_1109701.awb")

						arg_138_1:RecordAudio("1109701033", var_141_23)
						arg_138_1:RecordAudio("1109701033", var_141_23)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701033", "story_v_side_new_1109701.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701033", "story_v_side_new_1109701.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_24 = math.max(var_141_17, arg_138_1.talkMaxDuration)

			if var_141_16 <= arg_138_1.time_ and arg_138_1.time_ < var_141_16 + var_141_24 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_16) / var_141_24

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_16 + var_141_24 and arg_138_1.time_ < var_141_16 + var_141_24 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play1109701034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1109701034
		arg_142_1.duration_ = 3.17

		local var_142_0 = {
			zh = 2,
			ja = 3.166
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1109701035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos6046_story = arg_142_1.actors_["6046_story"].transform.localPosition

				local var_145_0 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_0 then
					var_145_0:EnableDynamicBone(false)
				end
			end

			local var_145_1 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_1 then
				arg_142_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_142_1.time_ - 0) / var_145_1)
				arg_142_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["6046_story"].transform.position).z)
				arg_142_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["6046_story"].transform.localEulerAngles = arg_142_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_1 and arg_142_1.time_ < 0 + var_145_1 + arg_145_0 then
				arg_142_1.actors_["6046_story"].transform.localPosition = Vector3.New(0.7, -0.5, -6.3)
				arg_142_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["6046_story"].transform.position).z)
				arg_142_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["6046_story"].transform.localEulerAngles = arg_142_1.actors_["6046_story"].transform.localEulerAngles

				local var_145_2 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_2 then
					var_145_2:EnableDynamicBone(true)
				end
			end

			local var_145_3 = arg_142_1.actors_["6046_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_3) and arg_142_1.var_.characterEffect6046_story == nil then
				arg_142_1.var_.characterEffect6046_story = var_145_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_4 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 and not isNil(var_145_3) then
				if arg_142_1.var_.characterEffect6046_story and not isNil(var_145_3) then
					arg_142_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 and not isNil(var_145_3) and arg_142_1.var_.characterEffect6046_story then
				arg_142_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_145_6 = arg_142_1.actors_["6045_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_6) and arg_142_1.var_.characterEffect6045_story == nil then
				arg_142_1.var_.characterEffect6045_story = var_145_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_7 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 and not isNil(var_145_6) then
				if arg_142_1.var_.characterEffect6045_story and not isNil(var_145_6) then
					arg_142_1.var_.characterEffect6045_story.fillFlat = true
					arg_142_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_7)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 and not isNil(var_145_6) and arg_142_1.var_.characterEffect6045_story then
				arg_142_1.var_.characterEffect6045_story.fillFlat = true
				arg_142_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_145_8 = 0
			local var_145_9 = 0.125

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_8 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_10 = arg_142_1:GetWordFromCfg(1109701034)
				local var_145_11 = arg_142_1:FormatText(var_145_10.content)

				arg_142_1.text_.text = var_145_11

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_13 = 5 <= 0 and var_145_9 or var_145_9 * (utf8.len(var_145_11) / 5)

				if (5 <= 0 and var_145_9 or var_145_9 * (utf8.len(var_145_11) / 5)) > 0 and var_145_9 < var_145_13 then
					arg_142_1.talkMaxDuration = var_145_13

					if var_145_13 + var_145_8 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_13 + var_145_8
					end
				end

				arg_142_1.text_.text = var_145_11
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701034", "story_v_side_new_1109701.awb") ~= 0 then
					local var_145_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701034", "story_v_side_new_1109701.awb") / 1000

					if var_145_14 + var_145_8 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_14 + var_145_8
					end

					if var_145_10.prefab_name ~= "" and arg_142_1.actors_[var_145_10.prefab_name] ~= nil then
						local var_145_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_10.prefab_name].transform, "story_v_side_new_1109701", "1109701034", "story_v_side_new_1109701.awb")

						arg_142_1:RecordAudio("1109701034", var_145_15)
						arg_142_1:RecordAudio("1109701034", var_145_15)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701034", "story_v_side_new_1109701.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701034", "story_v_side_new_1109701.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_16 = math.max(var_145_9, arg_142_1.talkMaxDuration)

			if var_145_8 <= arg_142_1.time_ and arg_142_1.time_ < var_145_8 + var_145_16 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_8) / var_145_16

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_8 + var_145_16 and arg_142_1.time_ < var_145_8 + var_145_16 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play1109701035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1109701035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1109701036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["6046_story"]) and arg_146_1.var_.characterEffect6046_story == nil then
				arg_146_1.var_.characterEffect6046_story = arg_146_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["6046_story"]) then
				if arg_146_1.var_.characterEffect6046_story and not isNil(arg_146_1.actors_["6046_story"]) then
					arg_146_1.var_.characterEffect6046_story.fillFlat = true
					arg_146_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_0)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["6046_story"]) and arg_146_1.var_.characterEffect6046_story then
				arg_146_1.var_.characterEffect6046_story.fillFlat = true
				arg_146_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_149_1 = 0
			local var_149_2 = 0.1

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(1109701035).content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 4 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 4)

				if (4 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 4)) > 0 and var_149_2 < var_149_5 then
					arg_146_1.talkMaxDuration = var_149_5

					if var_149_5 + var_149_1 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + var_149_1
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_6 = math.max(var_149_2, arg_146_1.talkMaxDuration)

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_6 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_1) / var_149_6

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_1 + var_149_6 and arg_146_1.time_ < var_149_1 + var_149_6 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1109701036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1109701036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1109701037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.4

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_1 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(1109701036).content)

				arg_150_1.text_.text = var_153_1

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_3 = 16 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 16)

				if (16 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 16)) > 0 and var_153_0 < var_153_3 then
					arg_150_1.talkMaxDuration = var_153_3

					if var_153_3 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_3 + 0
					end
				end

				arg_150_1.text_.text = var_153_1
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_4 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_4

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play1109701037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1109701037
		arg_154_1.duration_ = 2

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1109701038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1097ui_story = arg_154_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_157_0 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 then
				arg_154_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_154_1.time_ - 0) / var_157_0)
				arg_154_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1097ui_story"].transform.position).z)
				arg_154_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1097ui_story"].transform.localEulerAngles = arg_154_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 then
				arg_154_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_154_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1097ui_story"].transform.position).z)
				arg_154_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1097ui_story"].transform.localEulerAngles = arg_154_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_157_1 = arg_154_1.actors_["1097ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_1) and arg_154_1.var_.characterEffect1097ui_story == nil then
				arg_154_1.var_.characterEffect1097ui_story = var_157_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_2 and not isNil(var_157_1) then
				if arg_154_1.var_.characterEffect1097ui_story and not isNil(var_157_1) then
					arg_154_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_2 and arg_154_1.time_ < 0 + var_157_2 + arg_157_0 and not isNil(var_157_1) and arg_154_1.var_.characterEffect1097ui_story then
				arg_154_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_157_4 = arg_154_1.actors_["6045_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos6045_story = var_157_4.localPosition

				local var_157_5 = GameObjectTools.GetOrAddComponent(var_157_4.gameObject, typeof(DynamicBoneHelper))

				if var_157_5 then
					var_157_5:EnableDynamicBone(false)
				end
			end

			local var_157_6 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_6 then
				var_157_4.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_6)
				var_157_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_4.position).x, (manager.ui.mainCamera.transform.position - var_157_4.position).y, (manager.ui.mainCamera.transform.position - var_157_4.position).z)
				var_157_4.localEulerAngles.z = 0
				var_157_4.localEulerAngles.x = 0
				var_157_4.localEulerAngles = var_157_4.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_6 and arg_154_1.time_ < 0 + var_157_6 + arg_157_0 then
				var_157_4.localPosition = Vector3.New(0, 100, 0)
				var_157_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_4.position).x, (manager.ui.mainCamera.transform.position - var_157_4.position).y, (manager.ui.mainCamera.transform.position - var_157_4.position).z)
				var_157_4.localEulerAngles.z = 0
				var_157_4.localEulerAngles.x = 0
				var_157_4.localEulerAngles = var_157_4.localEulerAngles

				local var_157_7 = GameObjectTools.GetOrAddComponent(var_157_4.gameObject, typeof(DynamicBoneHelper))

				if var_157_7 then
					var_157_7:EnableDynamicBone(true)
				end
			end

			local var_157_8 = arg_154_1.actors_["6045_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_8) and arg_154_1.var_.characterEffect6045_story == nil then
				arg_154_1.var_.characterEffect6045_story = var_157_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_9 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_9 and not isNil(var_157_8) then
				if arg_154_1.var_.characterEffect6045_story and not isNil(var_157_8) then
					arg_154_1.var_.characterEffect6045_story.fillFlat = true
					arg_154_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_9)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_9 and arg_154_1.time_ < 0 + var_157_9 + arg_157_0 and not isNil(var_157_8) and arg_154_1.var_.characterEffect6045_story then
				arg_154_1.var_.characterEffect6045_story.fillFlat = true
				arg_154_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_157_10 = arg_154_1.actors_["6046_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos6046_story = var_157_10.localPosition

				local var_157_11 = GameObjectTools.GetOrAddComponent(var_157_10.gameObject, typeof(DynamicBoneHelper))

				if var_157_11 then
					var_157_11:EnableDynamicBone(false)
				end
			end

			local var_157_12 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_12 then
				var_157_10.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_12)
				var_157_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_10.position).x, (manager.ui.mainCamera.transform.position - var_157_10.position).y, (manager.ui.mainCamera.transform.position - var_157_10.position).z)
				var_157_10.localEulerAngles.z = 0
				var_157_10.localEulerAngles.x = 0
				var_157_10.localEulerAngles = var_157_10.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_12 and arg_154_1.time_ < 0 + var_157_12 + arg_157_0 then
				var_157_10.localPosition = Vector3.New(0, 100, 0)
				var_157_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_10.position).x, (manager.ui.mainCamera.transform.position - var_157_10.position).y, (manager.ui.mainCamera.transform.position - var_157_10.position).z)
				var_157_10.localEulerAngles.z = 0
				var_157_10.localEulerAngles.x = 0
				var_157_10.localEulerAngles = var_157_10.localEulerAngles

				local var_157_13 = GameObjectTools.GetOrAddComponent(var_157_10.gameObject, typeof(DynamicBoneHelper))

				if var_157_13 then
					var_157_13:EnableDynamicBone(true)
				end
			end

			local var_157_14 = arg_154_1.actors_["6046_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_14) and arg_154_1.var_.characterEffect6046_story == nil then
				arg_154_1.var_.characterEffect6046_story = var_157_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_15 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_15 and not isNil(var_157_14) then
				if arg_154_1.var_.characterEffect6046_story and not isNil(var_157_14) then
					arg_154_1.var_.characterEffect6046_story.fillFlat = true
					arg_154_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_15)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_15 and arg_154_1.time_ < 0 + var_157_15 + arg_157_0 and not isNil(var_157_14) and arg_154_1.var_.characterEffect6046_story then
				arg_154_1.var_.characterEffect6046_story.fillFlat = true
				arg_154_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_157_16 = 0
			local var_157_17 = 0.075

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_16 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_18 = arg_154_1:GetWordFromCfg(1109701037)
				local var_157_19 = arg_154_1:FormatText(var_157_18.content)

				arg_154_1.text_.text = var_157_19

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_21 = 3 <= 0 and var_157_17 or var_157_17 * (utf8.len(var_157_19) / 3)

				if (3 <= 0 and var_157_17 or var_157_17 * (utf8.len(var_157_19) / 3)) > 0 and var_157_17 < var_157_21 then
					arg_154_1.talkMaxDuration = var_157_21

					if var_157_21 + var_157_16 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_21 + var_157_16
					end
				end

				arg_154_1.text_.text = var_157_19
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701037", "story_v_side_new_1109701.awb") ~= 0 then
					local var_157_22 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701037", "story_v_side_new_1109701.awb") / 1000

					if var_157_22 + var_157_16 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_22 + var_157_16
					end

					if var_157_18.prefab_name ~= "" and arg_154_1.actors_[var_157_18.prefab_name] ~= nil then
						local var_157_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_18.prefab_name].transform, "story_v_side_new_1109701", "1109701037", "story_v_side_new_1109701.awb")

						arg_154_1:RecordAudio("1109701037", var_157_23)
						arg_154_1:RecordAudio("1109701037", var_157_23)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701037", "story_v_side_new_1109701.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701037", "story_v_side_new_1109701.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_24 = math.max(var_157_17, arg_154_1.talkMaxDuration)

			if var_157_16 <= arg_154_1.time_ and arg_154_1.time_ < var_157_16 + var_157_24 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_16) / var_157_24

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_16 + var_157_24 and arg_154_1.time_ < var_157_16 + var_157_24 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play1109701038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1109701038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1109701039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1097ui_story"]) and arg_158_1.var_.characterEffect1097ui_story == nil then
				arg_158_1.var_.characterEffect1097ui_story = arg_158_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1097ui_story"]) then
				if arg_158_1.var_.characterEffect1097ui_story and not isNil(arg_158_1.actors_["1097ui_story"]) then
					arg_158_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_0)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1097ui_story"]) and arg_158_1.var_.characterEffect1097ui_story then
				arg_158_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_161_1 = 0
			local var_161_2 = 0.775

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_3 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(1109701038).content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 31 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 31)

				if (31 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 31)) > 0 and var_161_2 < var_161_5 then
					arg_158_1.talkMaxDuration = var_161_5

					if var_161_5 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_6 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_6 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_6

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_6 and arg_158_1.time_ < var_161_1 + var_161_6 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1109701039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1109701039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1109701040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.225

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(1109701039).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 9 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 9)

				if (9 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 9)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1109701040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1109701040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1109701041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0.3

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_1 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(1109701040).content)

				arg_166_1.text_.text = var_169_1

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_3 = 12 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 12)

				if (12 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 12)) > 0 and var_169_0 < var_169_3 then
					arg_166_1.talkMaxDuration = var_169_3

					if var_169_3 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_3 + 0
					end
				end

				arg_166_1.text_.text = var_169_1
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_4 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_4

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play1109701041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1109701041
		arg_170_1.duration_ = 4.83

		local var_170_0 = {
			zh = 4.833,
			ja = 2.099999999999
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1109701042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_9000

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1097ui_story = arg_170_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1097ui_story"].transform.position).z)
				arg_170_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1097ui_story"].transform.localEulerAngles = arg_170_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_170_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1097ui_story"].transform.position).z)
				arg_170_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1097ui_story"].transform.localEulerAngles = arg_170_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_173_1 = arg_170_1.actors_["1097ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1097ui_story == nil then
				arg_170_1.var_.characterEffect1097ui_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 and not isNil(var_173_1) then
				if arg_170_1.var_.characterEffect1097ui_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1097ui_story then
				arg_170_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action5_1")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				local var_173_4 = arg_170_1.var_.effect1097ui_storyyangchuxian1

				if not arg_170_1.var_.effect1097ui_storyyangchuxian1 then
					var_173_4 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"), arg_170_1.actors_["1097ui_story"].transform)
					var_173_4.name = "yangchuxian1"
					arg_170_1.var_.effect1097ui_storyyangchuxian1 = var_173_4
				else
					var_173_4.transform:SetParent(var_173_9000)
				end

				var_173_4.transform.localPosition = Vector3.New(0, 1.28, 0.3)
				var_173_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_170_1.time_ and arg_170_1.time_ <= 2 + arg_173_0 then
				if arg_170_1.var_.effect1097ui_storyyangchuxian1 then
					Object.Destroy(arg_170_1.var_.effect1097ui_storyyangchuxian1)

					arg_170_1.var_.effect1097ui_storyyangchuxian1 = nil
				end
			end

			local var_173_7 = 0
			local var_173_8 = 0.6

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_7 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_9 = arg_170_1:GetWordFromCfg(1109701041)
				local var_173_10 = arg_170_1:FormatText(var_173_9.content)

				arg_170_1.text_.text = var_173_10

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_12 = 24 <= 0 and var_173_8 or var_173_8 * (utf8.len(var_173_10) / 24)

				if (24 <= 0 and var_173_8 or var_173_8 * (utf8.len(var_173_10) / 24)) > 0 and var_173_8 < var_173_12 then
					arg_170_1.talkMaxDuration = var_173_12

					if var_173_12 + var_173_7 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_12 + var_173_7
					end
				end

				arg_170_1.text_.text = var_173_10
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701041", "story_v_side_new_1109701.awb") ~= 0 then
					local var_173_13 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701041", "story_v_side_new_1109701.awb") / 1000

					if var_173_13 + var_173_7 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_7
					end

					if var_173_9.prefab_name ~= "" and arg_170_1.actors_[var_173_9.prefab_name] ~= nil then
						local var_173_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_9.prefab_name].transform, "story_v_side_new_1109701", "1109701041", "story_v_side_new_1109701.awb")

						arg_170_1:RecordAudio("1109701041", var_173_14)
						arg_170_1:RecordAudio("1109701041", var_173_14)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701041", "story_v_side_new_1109701.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701041", "story_v_side_new_1109701.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_15 = math.max(var_173_8, arg_170_1.talkMaxDuration)

			if var_173_7 <= arg_170_1.time_ and arg_170_1.time_ < var_173_7 + var_173_15 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_7) / var_173_15

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_7 + var_173_15 and arg_170_1.time_ < var_173_7 + var_173_15 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play1109701042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1109701042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1109701043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1097ui_story"]) and arg_174_1.var_.characterEffect1097ui_story == nil then
				arg_174_1.var_.characterEffect1097ui_story = arg_174_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1097ui_story"]) then
				if arg_174_1.var_.characterEffect1097ui_story and not isNil(arg_174_1.actors_["1097ui_story"]) then
					arg_174_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_0)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1097ui_story"]) and arg_174_1.var_.characterEffect1097ui_story then
				arg_174_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_177_1 = 0
			local var_177_2 = 0.325

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_3 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(1109701042).content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 13 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 13)

				if (13 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 13)) > 0 and var_177_2 < var_177_5 then
					arg_174_1.talkMaxDuration = var_177_5

					if var_177_5 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + var_177_1
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_6 = math.max(var_177_2, arg_174_1.talkMaxDuration)

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_6 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_1) / var_177_6

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_1 + var_177_6 and arg_174_1.time_ < var_177_1 + var_177_6 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1109701043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1109701043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1109701044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1097ui_story = arg_178_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1097ui_story"].transform.position).z)
				arg_178_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1097ui_story"].transform.localEulerAngles = arg_178_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1097ui_story"].transform.position).z)
				arg_178_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1097ui_story"].transform.localEulerAngles = arg_178_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_181_1 = 0
			local var_181_2 = 0.525

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(1109701043).content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 21 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 21)

				if (21 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 21)) > 0 and var_181_2 < var_181_5 then
					arg_178_1.talkMaxDuration = var_181_5

					if var_181_5 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_6 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_6 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_6

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_6 and arg_178_1.time_ < var_181_1 + var_181_6 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play1109701044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1109701044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1109701045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.075

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_1 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(1109701044).content)

				arg_182_1.text_.text = var_185_1

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_3 = 3 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 3)

				if (3 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 3)) > 0 and var_185_0 < var_185_3 then
					arg_182_1.talkMaxDuration = var_185_3

					if var_185_3 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_3 + 0
					end
				end

				arg_182_1.text_.text = var_185_1
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_4 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_4

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play1109701045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1109701045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1109701046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.75

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_1 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(1109701045).content)

				arg_186_1.text_.text = var_189_1

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_3 = 30 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 30)

				if (30 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 30)) > 0 and var_189_0 < var_189_3 then
					arg_186_1.talkMaxDuration = var_189_3

					if var_189_3 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_3 + 0
					end
				end

				arg_186_1.text_.text = var_189_1
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_4 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_4

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play1109701046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1109701046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1109701047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.3

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_1 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(1109701046).content)

				arg_190_1.text_.text = var_193_1

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_3 = 12 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 12)

				if (12 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 12)) > 0 and var_193_0 < var_193_3 then
					arg_190_1.talkMaxDuration = var_193_3

					if var_193_3 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_3 + 0
					end
				end

				arg_190_1.text_.text = var_193_1
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_4 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_4

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1109701047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1109701047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1109701048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 1.15

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_1 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(1109701047).content)

				arg_194_1.text_.text = var_197_1

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_3 = 46 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 46)

				if (46 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 46)) > 0 and var_197_0 < var_197_3 then
					arg_194_1.talkMaxDuration = var_197_3

					if var_197_3 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_3 + 0
					end
				end

				arg_194_1.text_.text = var_197_1
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_4 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_4

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1109701048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1109701048
		arg_198_1.duration_ = 5.17

		local var_198_0 = {
			zh = 5.166,
			ja = 3.933
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1109701049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1097ui_story = arg_198_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1097ui_story"].transform.position).z)
				arg_198_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1097ui_story"].transform.localEulerAngles = arg_198_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_198_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1097ui_story"].transform.position).z)
				arg_198_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1097ui_story"].transform.localEulerAngles = arg_198_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["1097ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1097ui_story == nil then
				arg_198_1.var_.characterEffect1097ui_story = var_201_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 and not isNil(var_201_1) then
				if arg_198_1.var_.characterEffect1097ui_story and not isNil(var_201_1) then
					arg_198_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1097ui_story then
				arg_198_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_201_4 = 0
			local var_201_5 = 0.675

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:GetWordFromCfg(1109701048)
				local var_201_7 = arg_198_1:FormatText(var_201_6.content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 27 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 27)

				if (27 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 27)) > 0 and var_201_5 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701048", "story_v_side_new_1109701.awb") ~= 0 then
					local var_201_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701048", "story_v_side_new_1109701.awb") / 1000

					if var_201_10 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_4
					end

					if var_201_6.prefab_name ~= "" and arg_198_1.actors_[var_201_6.prefab_name] ~= nil then
						local var_201_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_6.prefab_name].transform, "story_v_side_new_1109701", "1109701048", "story_v_side_new_1109701.awb")

						arg_198_1:RecordAudio("1109701048", var_201_11)
						arg_198_1:RecordAudio("1109701048", var_201_11)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701048", "story_v_side_new_1109701.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701048", "story_v_side_new_1109701.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_12 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_12 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_12

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_12 and arg_198_1.time_ < var_201_4 + var_201_12 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play1109701049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1109701049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1109701050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1097ui_story"]) and arg_202_1.var_.characterEffect1097ui_story == nil then
				arg_202_1.var_.characterEffect1097ui_story = arg_202_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1097ui_story"]) then
				if arg_202_1.var_.characterEffect1097ui_story and not isNil(arg_202_1.actors_["1097ui_story"]) then
					arg_202_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1097ui_story"]) and arg_202_1.var_.characterEffect1097ui_story then
				arg_202_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_205_1 = 0
			local var_205_2 = 0.4

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(1109701049).content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 16 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 16)

				if (16 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 16)) > 0 and var_205_2 < var_205_5 then
					arg_202_1.talkMaxDuration = var_205_5

					if var_205_5 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_6 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_6 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_1) / var_205_6

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_1 + var_205_6 and arg_202_1.time_ < var_205_1 + var_205_6 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play1109701050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1109701050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1109701051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 1.1

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(1109701050).content)

				arg_206_1.text_.text = var_209_1

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_3 = 44 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 44)

				if (44 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 44)) > 0 and var_209_0 < var_209_3 then
					arg_206_1.talkMaxDuration = var_209_3

					if var_209_3 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_3 + 0
					end
				end

				arg_206_1.text_.text = var_209_1
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_4 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_4

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1109701051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1109701051
		arg_210_1.duration_ = 4.7

		local var_210_0 = {
			zh = 4.7,
			ja = 4.2
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1109701052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1097ui_story"]) and arg_210_1.var_.characterEffect1097ui_story == nil then
				arg_210_1.var_.characterEffect1097ui_story = arg_210_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1097ui_story"]) then
				if arg_210_1.var_.characterEffect1097ui_story and not isNil(arg_210_1.actors_["1097ui_story"]) then
					arg_210_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1097ui_story"]) and arg_210_1.var_.characterEffect1097ui_story then
				arg_210_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_213_2 = 0
			local var_213_3 = 0.3

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_4 = arg_210_1:GetWordFromCfg(1109701051)
				local var_213_5 = arg_210_1:FormatText(var_213_4.content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 12 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 12)

				if (12 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 12)) > 0 and var_213_3 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701051", "story_v_side_new_1109701.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701051", "story_v_side_new_1109701.awb") / 1000

					if var_213_8 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_2
					end

					if var_213_4.prefab_name ~= "" and arg_210_1.actors_[var_213_4.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_4.prefab_name].transform, "story_v_side_new_1109701", "1109701051", "story_v_side_new_1109701.awb")

						arg_210_1:RecordAudio("1109701051", var_213_9)
						arg_210_1:RecordAudio("1109701051", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701051", "story_v_side_new_1109701.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701051", "story_v_side_new_1109701.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_10 and arg_210_1.time_ < var_213_2 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play1109701052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1109701052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1109701053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1097ui_story"]) and arg_214_1.var_.characterEffect1097ui_story == nil then
				arg_214_1.var_.characterEffect1097ui_story = arg_214_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1097ui_story"]) then
				if arg_214_1.var_.characterEffect1097ui_story and not isNil(arg_214_1.actors_["1097ui_story"]) then
					arg_214_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1097ui_story"]) and arg_214_1.var_.characterEffect1097ui_story then
				arg_214_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 0.175

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(1109701052).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 7 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 7)

				if (7 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 7)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1109701053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1109701053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1109701054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 1.15

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(1109701053).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 46 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 46)

				if (46 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 46)) > 0 and var_221_0 < var_221_3 then
					arg_218_1.talkMaxDuration = var_221_3

					if var_221_3 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_3 + 0
					end
				end

				arg_218_1.text_.text = var_221_1
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_4 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_4

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1109701054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1109701054
		arg_222_1.duration_ = 3.63

		local var_222_0 = {
			zh = 2.6,
			ja = 3.633
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1109701055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1097ui_story = arg_222_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1097ui_story"].transform.position).z)
				arg_222_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1097ui_story"].transform.localEulerAngles = arg_222_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_222_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1097ui_story"].transform.position).z)
				arg_222_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1097ui_story"].transform.localEulerAngles = arg_222_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_225_1 = arg_222_1.actors_["1097ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1097ui_story == nil then
				arg_222_1.var_.characterEffect1097ui_story = var_225_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 and not isNil(var_225_1) then
				if arg_222_1.var_.characterEffect1097ui_story and not isNil(var_225_1) then
					arg_222_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_2)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1097ui_story then
				arg_222_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_225_3 = arg_222_1.actors_["6045_story"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos6045_story = var_225_3.localPosition

				local var_225_4 = GameObjectTools.GetOrAddComponent(var_225_3.gameObject, typeof(DynamicBoneHelper))

				if var_225_4 then
					var_225_4:EnableDynamicBone(false)
				end
			end

			local var_225_5 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_5 then
				var_225_3.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_222_1.time_ - 0) / var_225_5)
				var_225_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_3.position).x, (manager.ui.mainCamera.transform.position - var_225_3.position).y, (manager.ui.mainCamera.transform.position - var_225_3.position).z)
				var_225_3.localEulerAngles.z = 0
				var_225_3.localEulerAngles.x = 0
				var_225_3.localEulerAngles = var_225_3.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_5 and arg_222_1.time_ < 0 + var_225_5 + arg_225_0 then
				var_225_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_225_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_3.position).x, (manager.ui.mainCamera.transform.position - var_225_3.position).y, (manager.ui.mainCamera.transform.position - var_225_3.position).z)
				var_225_3.localEulerAngles.z = 0
				var_225_3.localEulerAngles.x = 0
				var_225_3.localEulerAngles = var_225_3.localEulerAngles

				local var_225_6 = GameObjectTools.GetOrAddComponent(var_225_3.gameObject, typeof(DynamicBoneHelper))

				if var_225_6 then
					var_225_6:EnableDynamicBone(true)
				end
			end

			local var_225_7 = arg_222_1.actors_["6045_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_7) and arg_222_1.var_.characterEffect6045_story == nil then
				arg_222_1.var_.characterEffect6045_story = var_225_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_8 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_8 and not isNil(var_225_7) then
				if arg_222_1.var_.characterEffect6045_story and not isNil(var_225_7) then
					arg_222_1.var_.characterEffect6045_story.fillFlat = true
					arg_222_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_8)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_8 and arg_222_1.time_ < 0 + var_225_8 + arg_225_0 and not isNil(var_225_7) and arg_222_1.var_.characterEffect6045_story then
				arg_222_1.var_.characterEffect6045_story.fillFlat = true
				arg_222_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_225_9 = arg_222_1.actors_["6046_story"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos6046_story = var_225_9.localPosition

				local var_225_10 = GameObjectTools.GetOrAddComponent(var_225_9.gameObject, typeof(DynamicBoneHelper))

				if var_225_10 then
					var_225_10:EnableDynamicBone(false)
				end
			end

			local var_225_11 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_11 then
				var_225_9.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_222_1.time_ - 0) / var_225_11)
				var_225_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_9.position).x, (manager.ui.mainCamera.transform.position - var_225_9.position).y, (manager.ui.mainCamera.transform.position - var_225_9.position).z)
				var_225_9.localEulerAngles.z = 0
				var_225_9.localEulerAngles.x = 0
				var_225_9.localEulerAngles = var_225_9.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_11 and arg_222_1.time_ < 0 + var_225_11 + arg_225_0 then
				var_225_9.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_225_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_9.position).x, (manager.ui.mainCamera.transform.position - var_225_9.position).y, (manager.ui.mainCamera.transform.position - var_225_9.position).z)
				var_225_9.localEulerAngles.z = 0
				var_225_9.localEulerAngles.x = 0
				var_225_9.localEulerAngles = var_225_9.localEulerAngles

				local var_225_12 = GameObjectTools.GetOrAddComponent(var_225_9.gameObject, typeof(DynamicBoneHelper))

				if var_225_12 then
					var_225_12:EnableDynamicBone(true)
				end
			end

			local var_225_13 = arg_222_1.actors_["6046_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_13) and arg_222_1.var_.characterEffect6046_story == nil then
				arg_222_1.var_.characterEffect6046_story = var_225_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_14 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_14 and not isNil(var_225_13) then
				if arg_222_1.var_.characterEffect6046_story and not isNil(var_225_13) then
					arg_222_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_14 and arg_222_1.time_ < 0 + var_225_14 + arg_225_0 and not isNil(var_225_13) and arg_222_1.var_.characterEffect6046_story then
				arg_222_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_225_16 = 0
			local var_225_17 = 0.225

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_16 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_18 = arg_222_1:GetWordFromCfg(1109701054)
				local var_225_19 = arg_222_1:FormatText(var_225_18.content)

				arg_222_1.text_.text = var_225_19

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_21 = 9 <= 0 and var_225_17 or var_225_17 * (utf8.len(var_225_19) / 9)

				if (9 <= 0 and var_225_17 or var_225_17 * (utf8.len(var_225_19) / 9)) > 0 and var_225_17 < var_225_21 then
					arg_222_1.talkMaxDuration = var_225_21

					if var_225_21 + var_225_16 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_21 + var_225_16
					end
				end

				arg_222_1.text_.text = var_225_19
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701054", "story_v_side_new_1109701.awb") ~= 0 then
					local var_225_22 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701054", "story_v_side_new_1109701.awb") / 1000

					if var_225_22 + var_225_16 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_22 + var_225_16
					end

					if var_225_18.prefab_name ~= "" and arg_222_1.actors_[var_225_18.prefab_name] ~= nil then
						local var_225_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_18.prefab_name].transform, "story_v_side_new_1109701", "1109701054", "story_v_side_new_1109701.awb")

						arg_222_1:RecordAudio("1109701054", var_225_23)
						arg_222_1:RecordAudio("1109701054", var_225_23)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701054", "story_v_side_new_1109701.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701054", "story_v_side_new_1109701.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_24 = math.max(var_225_17, arg_222_1.talkMaxDuration)

			if var_225_16 <= arg_222_1.time_ and arg_222_1.time_ < var_225_16 + var_225_24 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_16) / var_225_24

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_16 + var_225_24 and arg_222_1.time_ < var_225_16 + var_225_24 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play1109701055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1109701055
		arg_226_1.duration_ = 3.93

		local var_226_0 = {
			zh = 3.3,
			ja = 3.933
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1109701056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos6045_story = arg_226_1.actors_["6045_story"].transform.localPosition

				local var_229_0 = GameObjectTools.GetOrAddComponent(arg_226_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_229_0 then
					var_229_0:EnableDynamicBone(false)
				end
			end

			local var_229_1 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_1 then
				arg_226_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_226_1.time_ - 0) / var_229_1)
				arg_226_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["6045_story"].transform.position).z)
				arg_226_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["6045_story"].transform.localEulerAngles = arg_226_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_1 and arg_226_1.time_ < 0 + var_229_1 + arg_229_0 then
				arg_226_1.actors_["6045_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_226_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["6045_story"].transform.position).z)
				arg_226_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["6045_story"].transform.localEulerAngles = arg_226_1.actors_["6045_story"].transform.localEulerAngles

				local var_229_2 = GameObjectTools.GetOrAddComponent(arg_226_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_229_2 then
					var_229_2:EnableDynamicBone(true)
				end
			end

			local var_229_3 = arg_226_1.actors_["6045_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_3) and arg_226_1.var_.characterEffect6045_story == nil then
				arg_226_1.var_.characterEffect6045_story = var_229_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_4 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 and not isNil(var_229_3) then
				if arg_226_1.var_.characterEffect6045_story and not isNil(var_229_3) then
					arg_226_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 and not isNil(var_229_3) and arg_226_1.var_.characterEffect6045_story then
				arg_226_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_229_6 = arg_226_1.actors_["6046_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_6) and arg_226_1.var_.characterEffect6046_story == nil then
				arg_226_1.var_.characterEffect6046_story = var_229_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_7 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_7 and not isNil(var_229_6) then
				if arg_226_1.var_.characterEffect6046_story and not isNil(var_229_6) then
					arg_226_1.var_.characterEffect6046_story.fillFlat = true
					arg_226_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_7)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_7 and arg_226_1.time_ < 0 + var_229_7 + arg_229_0 and not isNil(var_229_6) and arg_226_1.var_.characterEffect6046_story then
				arg_226_1.var_.characterEffect6046_story.fillFlat = true
				arg_226_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_229_8 = 0
			local var_229_9 = 0.25

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_8 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_10 = arg_226_1:GetWordFromCfg(1109701055)
				local var_229_11 = arg_226_1:FormatText(var_229_10.content)

				arg_226_1.text_.text = var_229_11

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_13 = 10 <= 0 and var_229_9 or var_229_9 * (utf8.len(var_229_11) / 10)

				if (10 <= 0 and var_229_9 or var_229_9 * (utf8.len(var_229_11) / 10)) > 0 and var_229_9 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_8
					end
				end

				arg_226_1.text_.text = var_229_11
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701055", "story_v_side_new_1109701.awb") ~= 0 then
					local var_229_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701055", "story_v_side_new_1109701.awb") / 1000

					if var_229_14 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_14 + var_229_8
					end

					if var_229_10.prefab_name ~= "" and arg_226_1.actors_[var_229_10.prefab_name] ~= nil then
						local var_229_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_10.prefab_name].transform, "story_v_side_new_1109701", "1109701055", "story_v_side_new_1109701.awb")

						arg_226_1:RecordAudio("1109701055", var_229_15)
						arg_226_1:RecordAudio("1109701055", var_229_15)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701055", "story_v_side_new_1109701.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701055", "story_v_side_new_1109701.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_16 = math.max(var_229_9, arg_226_1.talkMaxDuration)

			if var_229_8 <= arg_226_1.time_ and arg_226_1.time_ < var_229_8 + var_229_16 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_8) / var_229_16

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_8 + var_229_16 and arg_226_1.time_ < var_229_8 + var_229_16 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play1109701056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1109701056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1109701057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["6045_story"]) and arg_230_1.var_.characterEffect6045_story == nil then
				arg_230_1.var_.characterEffect6045_story = arg_230_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["6045_story"]) then
				if arg_230_1.var_.characterEffect6045_story and not isNil(arg_230_1.actors_["6045_story"]) then
					arg_230_1.var_.characterEffect6045_story.fillFlat = true
					arg_230_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_0)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["6045_story"]) and arg_230_1.var_.characterEffect6045_story then
				arg_230_1.var_.characterEffect6045_story.fillFlat = true
				arg_230_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_233_1 = 0
			local var_233_2 = 0.25

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_3 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(1109701056).content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 10 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 10)

				if (10 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 10)) > 0 and var_233_2 < var_233_5 then
					arg_230_1.talkMaxDuration = var_233_5

					if var_233_5 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + var_233_1
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_6 = math.max(var_233_2, arg_230_1.talkMaxDuration)

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_6 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_1) / var_233_6

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_1 + var_233_6 and arg_230_1.time_ < var_233_1 + var_233_6 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1109701057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1109701057
		arg_234_1.duration_ = 6.37

		local var_234_0 = {
			zh = 6.333,
			ja = 6.366
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1109701058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1042ui_story = arg_234_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1042ui_story"].transform.position).z)
				arg_234_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1042ui_story"].transform.localEulerAngles = arg_234_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_234_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1042ui_story"].transform.position).z)
				arg_234_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1042ui_story"].transform.localEulerAngles = arg_234_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["1042ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1042ui_story == nil then
				arg_234_1.var_.characterEffect1042ui_story = var_237_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 and not isNil(var_237_1) then
				if arg_234_1.var_.characterEffect1042ui_story and not isNil(var_237_1) then
					arg_234_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1042ui_story then
				arg_234_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_237_4 = arg_234_1.actors_["6045_story"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos6045_story = var_237_4.localPosition

				local var_237_5 = GameObjectTools.GetOrAddComponent(var_237_4.gameObject, typeof(DynamicBoneHelper))

				if var_237_5 then
					var_237_5:EnableDynamicBone(false)
				end
			end

			local var_237_6 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_6 then
				var_237_4.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_234_1.time_ - 0) / var_237_6)
				var_237_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_4.position).x, (manager.ui.mainCamera.transform.position - var_237_4.position).y, (manager.ui.mainCamera.transform.position - var_237_4.position).z)
				var_237_4.localEulerAngles.z = 0
				var_237_4.localEulerAngles.x = 0
				var_237_4.localEulerAngles = var_237_4.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_6 and arg_234_1.time_ < 0 + var_237_6 + arg_237_0 then
				var_237_4.localPosition = Vector3.New(0, 100, 0)
				var_237_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_4.position).x, (manager.ui.mainCamera.transform.position - var_237_4.position).y, (manager.ui.mainCamera.transform.position - var_237_4.position).z)
				var_237_4.localEulerAngles.z = 0
				var_237_4.localEulerAngles.x = 0
				var_237_4.localEulerAngles = var_237_4.localEulerAngles

				local var_237_7 = GameObjectTools.GetOrAddComponent(var_237_4.gameObject, typeof(DynamicBoneHelper))

				if var_237_7 then
					var_237_7:EnableDynamicBone(true)
				end
			end

			local var_237_8 = arg_234_1.actors_["6045_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.characterEffect6045_story == nil then
				arg_234_1.var_.characterEffect6045_story = var_237_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_9 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_9 and not isNil(var_237_8) then
				if arg_234_1.var_.characterEffect6045_story and not isNil(var_237_8) then
					arg_234_1.var_.characterEffect6045_story.fillFlat = true
					arg_234_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_9)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_9 and arg_234_1.time_ < 0 + var_237_9 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.characterEffect6045_story then
				arg_234_1.var_.characterEffect6045_story.fillFlat = true
				arg_234_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_237_10 = arg_234_1.actors_["6046_story"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos6046_story = var_237_10.localPosition

				local var_237_11 = GameObjectTools.GetOrAddComponent(var_237_10.gameObject, typeof(DynamicBoneHelper))

				if var_237_11 then
					var_237_11:EnableDynamicBone(false)
				end
			end

			local var_237_12 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_12 then
				var_237_10.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_234_1.time_ - 0) / var_237_12)
				var_237_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_10.position).x, (manager.ui.mainCamera.transform.position - var_237_10.position).y, (manager.ui.mainCamera.transform.position - var_237_10.position).z)
				var_237_10.localEulerAngles.z = 0
				var_237_10.localEulerAngles.x = 0
				var_237_10.localEulerAngles = var_237_10.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_12 and arg_234_1.time_ < 0 + var_237_12 + arg_237_0 then
				var_237_10.localPosition = Vector3.New(0, 100, 0)
				var_237_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_10.position).x, (manager.ui.mainCamera.transform.position - var_237_10.position).y, (manager.ui.mainCamera.transform.position - var_237_10.position).z)
				var_237_10.localEulerAngles.z = 0
				var_237_10.localEulerAngles.x = 0
				var_237_10.localEulerAngles = var_237_10.localEulerAngles

				local var_237_13 = GameObjectTools.GetOrAddComponent(var_237_10.gameObject, typeof(DynamicBoneHelper))

				if var_237_13 then
					var_237_13:EnableDynamicBone(true)
				end
			end

			local var_237_14 = arg_234_1.actors_["6046_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_14) and arg_234_1.var_.characterEffect6046_story == nil then
				arg_234_1.var_.characterEffect6046_story = var_237_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_15 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_15 and not isNil(var_237_14) then
				if arg_234_1.var_.characterEffect6046_story and not isNil(var_237_14) then
					arg_234_1.var_.characterEffect6046_story.fillFlat = true
					arg_234_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_15)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_15 and arg_234_1.time_ < 0 + var_237_15 + arg_237_0 and not isNil(var_237_14) and arg_234_1.var_.characterEffect6046_story then
				arg_234_1.var_.characterEffect6046_story.fillFlat = true
				arg_234_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_237_16 = 0
			local var_237_17 = 0.8

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_18 = arg_234_1:GetWordFromCfg(1109701057)
				local var_237_19 = arg_234_1:FormatText(var_237_18.content)

				arg_234_1.text_.text = var_237_19

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_21 = 32 <= 0 and var_237_17 or var_237_17 * (utf8.len(var_237_19) / 32)

				if (32 <= 0 and var_237_17 or var_237_17 * (utf8.len(var_237_19) / 32)) > 0 and var_237_17 < var_237_21 then
					arg_234_1.talkMaxDuration = var_237_21

					if var_237_21 + var_237_16 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_21 + var_237_16
					end
				end

				arg_234_1.text_.text = var_237_19
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701057", "story_v_side_new_1109701.awb") ~= 0 then
					local var_237_22 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701057", "story_v_side_new_1109701.awb") / 1000

					if var_237_22 + var_237_16 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_22 + var_237_16
					end

					if var_237_18.prefab_name ~= "" and arg_234_1.actors_[var_237_18.prefab_name] ~= nil then
						local var_237_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_18.prefab_name].transform, "story_v_side_new_1109701", "1109701057", "story_v_side_new_1109701.awb")

						arg_234_1:RecordAudio("1109701057", var_237_23)
						arg_234_1:RecordAudio("1109701057", var_237_23)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701057", "story_v_side_new_1109701.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701057", "story_v_side_new_1109701.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_24 = math.max(var_237_17, arg_234_1.talkMaxDuration)

			if var_237_16 <= arg_234_1.time_ and arg_234_1.time_ < var_237_16 + var_237_24 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_16) / var_237_24

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_16 + var_237_24 and arg_234_1.time_ < var_237_16 + var_237_24 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play1109701058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1109701058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1109701059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1042ui_story"]) and arg_238_1.var_.characterEffect1042ui_story == nil then
				arg_238_1.var_.characterEffect1042ui_story = arg_238_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1042ui_story"]) then
				if arg_238_1.var_.characterEffect1042ui_story and not isNil(arg_238_1.actors_["1042ui_story"]) then
					arg_238_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1042ui_story"]) and arg_238_1.var_.characterEffect1042ui_story then
				arg_238_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 0.575

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(1109701058).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 23 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 23)

				if (23 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 23)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1109701059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1109701059
		arg_242_1.duration_ = 7.8

		local var_242_0 = {
			zh = 4.9,
			ja = 7.8
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1109701060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1042ui_story"]) and arg_242_1.var_.characterEffect1042ui_story == nil then
				arg_242_1.var_.characterEffect1042ui_story = arg_242_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1042ui_story"]) then
				if arg_242_1.var_.characterEffect1042ui_story and not isNil(arg_242_1.actors_["1042ui_story"]) then
					arg_242_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1042ui_story"]) and arg_242_1.var_.characterEffect1042ui_story then
				arg_242_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_245_2 = 0
			local var_245_3 = 0.65

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_4 = arg_242_1:GetWordFromCfg(1109701059)
				local var_245_5 = arg_242_1:FormatText(var_245_4.content)

				arg_242_1.text_.text = var_245_5

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_7 = 26 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_5) / 26)

				if (26 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_5) / 26)) > 0 and var_245_3 < var_245_7 then
					arg_242_1.talkMaxDuration = var_245_7

					if var_245_7 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_2
					end
				end

				arg_242_1.text_.text = var_245_5
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701059", "story_v_side_new_1109701.awb") ~= 0 then
					local var_245_8 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701059", "story_v_side_new_1109701.awb") / 1000

					if var_245_8 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_2
					end

					if var_245_4.prefab_name ~= "" and arg_242_1.actors_[var_245_4.prefab_name] ~= nil then
						local var_245_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_4.prefab_name].transform, "story_v_side_new_1109701", "1109701059", "story_v_side_new_1109701.awb")

						arg_242_1:RecordAudio("1109701059", var_245_9)
						arg_242_1:RecordAudio("1109701059", var_245_9)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701059", "story_v_side_new_1109701.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701059", "story_v_side_new_1109701.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_10 = math.max(var_245_3, arg_242_1.talkMaxDuration)

			if var_245_2 <= arg_242_1.time_ and arg_242_1.time_ < var_245_2 + var_245_10 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_2) / var_245_10

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_2 + var_245_10 and arg_242_1.time_ < var_245_2 + var_245_10 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play1109701060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1109701060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1109701061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1042ui_story"]) and arg_246_1.var_.characterEffect1042ui_story == nil then
				arg_246_1.var_.characterEffect1042ui_story = arg_246_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1042ui_story"]) then
				if arg_246_1.var_.characterEffect1042ui_story and not isNil(arg_246_1.actors_["1042ui_story"]) then
					arg_246_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_0)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1042ui_story"]) and arg_246_1.var_.characterEffect1042ui_story then
				arg_246_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_249_1 = 0
			local var_249_2 = 0.9

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_3 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(1109701060).content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 36 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 36)

				if (36 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 36)) > 0 and var_249_2 < var_249_5 then
					arg_246_1.talkMaxDuration = var_249_5

					if var_249_5 + var_249_1 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + var_249_1
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_6 = math.max(var_249_2, arg_246_1.talkMaxDuration)

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_6 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_1) / var_249_6

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_1 + var_249_6 and arg_246_1.time_ < var_249_1 + var_249_6 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1109701061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1109701061
		arg_250_1.duration_ = 8.57

		local var_250_0 = {
			zh = 6.966,
			ja = 8.566
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1109701062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1042ui_story"]) and arg_250_1.var_.characterEffect1042ui_story == nil then
				arg_250_1.var_.characterEffect1042ui_story = arg_250_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1042ui_story"]) then
				if arg_250_1.var_.characterEffect1042ui_story and not isNil(arg_250_1.actors_["1042ui_story"]) then
					arg_250_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1042ui_story"]) and arg_250_1.var_.characterEffect1042ui_story then
				arg_250_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_2")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_253_2 = 0
			local var_253_3 = 0.825

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_4 = arg_250_1:GetWordFromCfg(1109701061)
				local var_253_5 = arg_250_1:FormatText(var_253_4.content)

				arg_250_1.text_.text = var_253_5

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_7 = 33 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 33)

				if (33 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 33)) > 0 and var_253_3 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_2
					end
				end

				arg_250_1.text_.text = var_253_5
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701061", "story_v_side_new_1109701.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701061", "story_v_side_new_1109701.awb") / 1000

					if var_253_8 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_2
					end

					if var_253_4.prefab_name ~= "" and arg_250_1.actors_[var_253_4.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_4.prefab_name].transform, "story_v_side_new_1109701", "1109701061", "story_v_side_new_1109701.awb")

						arg_250_1:RecordAudio("1109701061", var_253_9)
						arg_250_1:RecordAudio("1109701061", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701061", "story_v_side_new_1109701.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701061", "story_v_side_new_1109701.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_3, arg_250_1.talkMaxDuration)

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_2) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_2 + var_253_10 and arg_250_1.time_ < var_253_2 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1109701062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1109701062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1109701063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1042ui_story"]) and arg_254_1.var_.characterEffect1042ui_story == nil then
				arg_254_1.var_.characterEffect1042ui_story = arg_254_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1042ui_story"]) then
				if arg_254_1.var_.characterEffect1042ui_story and not isNil(arg_254_1.actors_["1042ui_story"]) then
					arg_254_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_0)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1042ui_story"]) and arg_254_1.var_.characterEffect1042ui_story then
				arg_254_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_257_1 = 0
			local var_257_2 = 0.475

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_3 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(1109701062).content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 19 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 19)

				if (19 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 19)) > 0 and var_257_2 < var_257_5 then
					arg_254_1.talkMaxDuration = var_257_5

					if var_257_5 + var_257_1 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + var_257_1
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_6 = math.max(var_257_2, arg_254_1.talkMaxDuration)

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_6 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_1) / var_257_6

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_1 + var_257_6 and arg_254_1.time_ < var_257_1 + var_257_6 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1109701063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1109701063
		arg_258_1.duration_ = 4.5

		local var_258_0 = {
			zh = 4.5,
			ja = 3.933
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1109701064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1097ui_story = arg_258_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_261_0 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 then
				arg_258_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_258_1.time_ - 0) / var_261_0)
				arg_258_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1097ui_story"].transform.position).z)
				arg_258_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1097ui_story"].transform.localEulerAngles = arg_258_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 then
				arg_258_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_258_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1097ui_story"].transform.position).z)
				arg_258_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1097ui_story"].transform.localEulerAngles = arg_258_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_261_1 = arg_258_1.actors_["1097ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1097ui_story == nil then
				arg_258_1.var_.characterEffect1097ui_story = var_261_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 and not isNil(var_261_1) then
				if arg_258_1.var_.characterEffect1097ui_story and not isNil(var_261_1) then
					arg_258_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1097ui_story then
				arg_258_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_261_4 = arg_258_1.actors_["1042ui_story"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1042ui_story = var_261_4.localPosition
			end

			local var_261_5 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_5 then
				var_261_4.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_258_1.time_ - 0) / var_261_5)
				var_261_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_4.position).x, (manager.ui.mainCamera.transform.position - var_261_4.position).y, (manager.ui.mainCamera.transform.position - var_261_4.position).z)
				var_261_4.localEulerAngles.z = 0
				var_261_4.localEulerAngles.x = 0
				var_261_4.localEulerAngles = var_261_4.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_5 and arg_258_1.time_ < 0 + var_261_5 + arg_261_0 then
				var_261_4.localPosition = Vector3.New(0, 100, 0)
				var_261_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_4.position).x, (manager.ui.mainCamera.transform.position - var_261_4.position).y, (manager.ui.mainCamera.transform.position - var_261_4.position).z)
				var_261_4.localEulerAngles.z = 0
				var_261_4.localEulerAngles.x = 0
				var_261_4.localEulerAngles = var_261_4.localEulerAngles
			end

			local var_261_6 = arg_258_1.actors_["1042ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_6) and arg_258_1.var_.characterEffect1042ui_story == nil then
				arg_258_1.var_.characterEffect1042ui_story = var_261_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_7 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 and not isNil(var_261_6) then
				if arg_258_1.var_.characterEffect1042ui_story and not isNil(var_261_6) then
					arg_258_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_7)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 and not isNil(var_261_6) and arg_258_1.var_.characterEffect1042ui_story then
				arg_258_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_261_8 = 0
			local var_261_9 = 0.6

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_10 = arg_258_1:GetWordFromCfg(1109701063)
				local var_261_11 = arg_258_1:FormatText(var_261_10.content)

				arg_258_1.text_.text = var_261_11

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_13 = 24 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_11) / 24)

				if (24 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_11) / 24)) > 0 and var_261_9 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_8
					end
				end

				arg_258_1.text_.text = var_261_11
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701063", "story_v_side_new_1109701.awb") ~= 0 then
					local var_261_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701063", "story_v_side_new_1109701.awb") / 1000

					if var_261_14 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_14 + var_261_8
					end

					if var_261_10.prefab_name ~= "" and arg_258_1.actors_[var_261_10.prefab_name] ~= nil then
						local var_261_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_10.prefab_name].transform, "story_v_side_new_1109701", "1109701063", "story_v_side_new_1109701.awb")

						arg_258_1:RecordAudio("1109701063", var_261_15)
						arg_258_1:RecordAudio("1109701063", var_261_15)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701063", "story_v_side_new_1109701.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701063", "story_v_side_new_1109701.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_16 = math.max(var_261_9, arg_258_1.talkMaxDuration)

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_16 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_8) / var_261_16

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_8 + var_261_16 and arg_258_1.time_ < var_261_8 + var_261_16 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play1109701064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1109701064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1109701065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1097ui_story"]) and arg_262_1.var_.characterEffect1097ui_story == nil then
				arg_262_1.var_.characterEffect1097ui_story = arg_262_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1097ui_story"]) then
				if arg_262_1.var_.characterEffect1097ui_story and not isNil(arg_262_1.actors_["1097ui_story"]) then
					arg_262_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_0)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1097ui_story"]) and arg_262_1.var_.characterEffect1097ui_story then
				arg_262_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_265_1 = 0
			local var_265_2 = 0.5

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(1109701064).content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 20 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_3) / 20)

				if (20 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_3) / 20)) > 0 and var_265_2 < var_265_5 then
					arg_262_1.talkMaxDuration = var_265_5

					if var_265_5 + var_265_1 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + var_265_1
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_6 = math.max(var_265_2, arg_262_1.talkMaxDuration)

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_6 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_1) / var_265_6

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_1 + var_265_6 and arg_262_1.time_ < var_265_1 + var_265_6 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1109701065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1109701065
		arg_266_1.duration_ = 5.23

		local var_266_0 = {
			zh = 5.233,
			ja = 1.999999999999
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1109701066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1097ui_story = arg_266_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1097ui_story"].transform.position).z)
				arg_266_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1097ui_story"].transform.localEulerAngles = arg_266_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_266_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1097ui_story"].transform.position).z)
				arg_266_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1097ui_story"].transform.localEulerAngles = arg_266_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_269_1 = arg_266_1.actors_["1097ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1097ui_story == nil then
				arg_266_1.var_.characterEffect1097ui_story = var_269_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 and not isNil(var_269_1) then
				if arg_266_1.var_.characterEffect1097ui_story and not isNil(var_269_1) then
					arg_266_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1097ui_story then
				arg_266_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_269_4 = 0
			local var_269_5 = 0.6

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(1109701065)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 24 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 24)

				if (24 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 24)) > 0 and var_269_5 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701065", "story_v_side_new_1109701.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701065", "story_v_side_new_1109701.awb") / 1000

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end

					if var_269_6.prefab_name ~= "" and arg_266_1.actors_[var_269_6.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_6.prefab_name].transform, "story_v_side_new_1109701", "1109701065", "story_v_side_new_1109701.awb")

						arg_266_1:RecordAudio("1109701065", var_269_11)
						arg_266_1:RecordAudio("1109701065", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701065", "story_v_side_new_1109701.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701065", "story_v_side_new_1109701.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_12 and arg_266_1.time_ < var_269_4 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play1109701066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1109701066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1109701067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1097ui_story"]) and arg_270_1.var_.characterEffect1097ui_story == nil then
				arg_270_1.var_.characterEffect1097ui_story = arg_270_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1097ui_story"]) then
				if arg_270_1.var_.characterEffect1097ui_story and not isNil(arg_270_1.actors_["1097ui_story"]) then
					arg_270_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_0)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1097ui_story"]) and arg_270_1.var_.characterEffect1097ui_story then
				arg_270_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_273_1 = 0
			local var_273_2 = 0.95

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_3 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(1109701066).content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 38 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 38)

				if (38 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 38)) > 0 and var_273_2 < var_273_5 then
					arg_270_1.talkMaxDuration = var_273_5

					if var_273_5 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + var_273_1
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_6 = math.max(var_273_2, arg_270_1.talkMaxDuration)

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_6 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_1) / var_273_6

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_1 + var_273_6 and arg_270_1.time_ < var_273_1 + var_273_6 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1109701067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1109701067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1109701068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.675

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(1109701067).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 27 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 27)

				if (27 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 27)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1109701068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1109701068
		arg_278_1.duration_ = 9

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1109701069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				local var_281_0 = arg_278_1.bgs_.F01

				arg_278_1.bgs_.F01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_281_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_1 = var_281_0:GetComponent("SpriteRenderer")

				if var_281_1 and var_281_1.sprite then
					local var_281_2 = 2 * (var_281_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_281_0.transform.localScale = Vector3.New(var_281_2 / var_281_1.sprite.bounds.size.y < var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x and var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x or var_281_2 / var_281_1.sprite.bounds.size.y, var_281_2 / var_281_1.sprite.bounds.size.y < var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x and var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x or var_281_2 / var_281_1.sprite.bounds.size.y, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "F01" then
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

			local var_281_11 = arg_278_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_278_1.time_ and arg_278_1.time_ <= 1.96599999815226 + arg_281_0 then
				arg_278_1.var_.moveOldPos1097ui_story = var_281_11.localPosition
			end

			local var_281_12 = 0.001

			if 1.96599999815226 <= arg_278_1.time_ and arg_278_1.time_ < 1.96599999815226 + var_281_12 then
				var_281_11.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 1.96599999815226) / var_281_12)
				var_281_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_11.position).x, (manager.ui.mainCamera.transform.position - var_281_11.position).y, (manager.ui.mainCamera.transform.position - var_281_11.position).z)
				var_281_11.localEulerAngles.z = 0
				var_281_11.localEulerAngles.x = 0
				var_281_11.localEulerAngles = var_281_11.localEulerAngles
			end

			if arg_278_1.time_ >= 1.96599999815226 + var_281_12 and arg_278_1.time_ < 1.96599999815226 + var_281_12 + arg_281_0 then
				var_281_11.localPosition = Vector3.New(0, 100, 0)
				var_281_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_11.position).x, (manager.ui.mainCamera.transform.position - var_281_11.position).y, (manager.ui.mainCamera.transform.position - var_281_11.position).z)
				var_281_11.localEulerAngles.z = 0
				var_281_11.localEulerAngles.x = 0
				var_281_11.localEulerAngles = var_281_11.localEulerAngles
			end

			local var_281_13 = arg_278_1.actors_["1097ui_story"]

			if 1.96599999815226 < arg_278_1.time_ and arg_278_1.time_ <= 1.96599999815226 + arg_281_0 and not isNil(var_281_13) and arg_278_1.var_.characterEffect1097ui_story == nil then
				arg_278_1.var_.characterEffect1097ui_story = var_281_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_14 = 0.034000001847744

			if 1.96599999815226 <= arg_278_1.time_ and arg_278_1.time_ < 1.96599999815226 + var_281_14 and not isNil(var_281_13) then
				if arg_278_1.var_.characterEffect1097ui_story and not isNil(var_281_13) then
					arg_278_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 1.96599999815226) / var_281_14)
				end
			end

			if arg_278_1.time_ >= 1.96599999815226 + var_281_14 and arg_278_1.time_ < 1.96599999815226 + var_281_14 + arg_281_0 and not isNil(var_281_13) and arg_278_1.var_.characterEffect1097ui_story then
				arg_278_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_15 = 4
			local var_281_16 = 0.1

			if 4 < arg_278_1.time_ and arg_278_1.time_ <= var_281_15 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_17 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_17:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_18 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(1109701068).content)

				arg_278_1.text_.text = var_281_18

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_20 = 4 <= 0 and var_281_16 or var_281_16 * (utf8.len(var_281_18) / 4)

				if (4 <= 0 and var_281_16 or var_281_16 * (utf8.len(var_281_18) / 4)) > 0 and var_281_16 < var_281_20 then
					arg_278_1.talkMaxDuration = var_281_20
					var_281_15 = var_281_15 + 0.3

					if var_281_20 + var_281_15 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_20 + var_281_15
					end
				end

				arg_278_1.text_.text = var_281_18
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_21 = var_281_15 + 0.3
			local var_281_22 = math.max(var_281_16, arg_278_1.talkMaxDuration)

			if var_281_15 + 0.3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_21 + var_281_22 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_21) / var_281_22

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_21 + var_281_22 and arg_278_1.time_ < var_281_21 + var_281_22 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play1109701069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1109701069
		arg_284_1.duration_ = 3.63

		local var_284_0 = {
			zh = 3.633,
			ja = 2.766
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1109701070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1097ui_story = arg_284_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_287_0 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 then
				arg_284_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_284_1.time_ - 0) / var_287_0)
				arg_284_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).z)
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles = arg_284_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 then
				arg_284_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_284_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).z)
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles = arg_284_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_287_1 = arg_284_1.actors_["1097ui_story"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect1097ui_story == nil then
				arg_284_1.var_.characterEffect1097ui_story = var_287_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_2 and not isNil(var_287_1) then
				if arg_284_1.var_.characterEffect1097ui_story and not isNil(var_287_1) then
					arg_284_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= 0 + var_287_2 and arg_284_1.time_ < 0 + var_287_2 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect1097ui_story then
				arg_284_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_287_4 = 0
			local var_287_5 = 0.475

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_6 = arg_284_1:GetWordFromCfg(1109701069)
				local var_287_7 = arg_284_1:FormatText(var_287_6.content)

				arg_284_1.text_.text = var_287_7

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_9 = 19 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 19)

				if (19 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 19)) > 0 and var_287_5 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9

					if var_287_9 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_4
					end
				end

				arg_284_1.text_.text = var_287_7
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701069", "story_v_side_new_1109701.awb") ~= 0 then
					local var_287_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701069", "story_v_side_new_1109701.awb") / 1000

					if var_287_10 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_10 + var_287_4
					end

					if var_287_6.prefab_name ~= "" and arg_284_1.actors_[var_287_6.prefab_name] ~= nil then
						local var_287_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_6.prefab_name].transform, "story_v_side_new_1109701", "1109701069", "story_v_side_new_1109701.awb")

						arg_284_1:RecordAudio("1109701069", var_287_11)
						arg_284_1:RecordAudio("1109701069", var_287_11)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701069", "story_v_side_new_1109701.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701069", "story_v_side_new_1109701.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_12 = math.max(var_287_5, arg_284_1.talkMaxDuration)

			if var_287_4 <= arg_284_1.time_ and arg_284_1.time_ < var_287_4 + var_287_12 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_4) / var_287_12

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_4 + var_287_12 and arg_284_1.time_ < var_287_4 + var_287_12 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play1109701070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1109701070
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1109701071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1097ui_story"]) and arg_288_1.var_.characterEffect1097ui_story == nil then
				arg_288_1.var_.characterEffect1097ui_story = arg_288_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1097ui_story"]) then
				if arg_288_1.var_.characterEffect1097ui_story and not isNil(arg_288_1.actors_["1097ui_story"]) then
					arg_288_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_0)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1097ui_story"]) and arg_288_1.var_.characterEffect1097ui_story then
				arg_288_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_291_1 = 0
			local var_291_2 = 0.75

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_3 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(1109701070).content)

				arg_288_1.text_.text = var_291_3

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 30 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 30)

				if (30 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 30)) > 0 and var_291_2 < var_291_5 then
					arg_288_1.talkMaxDuration = var_291_5

					if var_291_5 + var_291_1 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + var_291_1
					end
				end

				arg_288_1.text_.text = var_291_3
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_6 = math.max(var_291_2, arg_288_1.talkMaxDuration)

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_6 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_1) / var_291_6

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_1 + var_291_6 and arg_288_1.time_ < var_291_1 + var_291_6 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1109701071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1109701071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1109701072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.625

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_1 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(1109701071).content)

				arg_292_1.text_.text = var_295_1

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_3 = 25 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 25)

				if (25 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 25)) > 0 and var_295_0 < var_295_3 then
					arg_292_1.talkMaxDuration = var_295_3

					if var_295_3 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_3 + 0
					end
				end

				arg_292_1.text_.text = var_295_1
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_4 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_4

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1109701072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1109701072
		arg_296_1.duration_ = 7.3

		local var_296_0 = {
			zh = 7.3,
			ja = 5.266
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1109701073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1097ui_story = arg_296_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).z)
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles = arg_296_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).z)
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles = arg_296_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_299_1 = arg_296_1.actors_["1097ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1097ui_story == nil then
				arg_296_1.var_.characterEffect1097ui_story = var_299_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_2 and not isNil(var_299_1) then
				if arg_296_1.var_.characterEffect1097ui_story and not isNil(var_299_1) then
					arg_296_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_2)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_2 and arg_296_1.time_ < 0 + var_299_2 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1097ui_story then
				arg_296_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_299_3 = arg_296_1.actors_["6045_story"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos6045_story = var_299_3.localPosition

				local var_299_4 = GameObjectTools.GetOrAddComponent(var_299_3.gameObject, typeof(DynamicBoneHelper))

				if var_299_4 then
					var_299_4:EnableDynamicBone(false)
				end
			end

			local var_299_5 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_5 then
				var_299_3.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_296_1.time_ - 0) / var_299_5)
				var_299_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_3.position).x, (manager.ui.mainCamera.transform.position - var_299_3.position).y, (manager.ui.mainCamera.transform.position - var_299_3.position).z)
				var_299_3.localEulerAngles.z = 0
				var_299_3.localEulerAngles.x = 0
				var_299_3.localEulerAngles = var_299_3.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_5 and arg_296_1.time_ < 0 + var_299_5 + arg_299_0 then
				var_299_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_299_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_3.position).x, (manager.ui.mainCamera.transform.position - var_299_3.position).y, (manager.ui.mainCamera.transform.position - var_299_3.position).z)
				var_299_3.localEulerAngles.z = 0
				var_299_3.localEulerAngles.x = 0
				var_299_3.localEulerAngles = var_299_3.localEulerAngles

				local var_299_6 = GameObjectTools.GetOrAddComponent(var_299_3.gameObject, typeof(DynamicBoneHelper))

				if var_299_6 then
					var_299_6:EnableDynamicBone(true)
				end
			end

			local var_299_7 = arg_296_1.actors_["6045_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_7) and arg_296_1.var_.characterEffect6045_story == nil then
				arg_296_1.var_.characterEffect6045_story = var_299_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_8 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_8 and not isNil(var_299_7) then
				if arg_296_1.var_.characterEffect6045_story and not isNil(var_299_7) then
					arg_296_1.var_.characterEffect6045_story.fillFlat = true
					arg_296_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_8)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_8 and arg_296_1.time_ < 0 + var_299_8 + arg_299_0 and not isNil(var_299_7) and arg_296_1.var_.characterEffect6045_story then
				arg_296_1.var_.characterEffect6045_story.fillFlat = true
				arg_296_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_299_9 = arg_296_1.actors_["6046_story"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos6046_story = var_299_9.localPosition

				local var_299_10 = GameObjectTools.GetOrAddComponent(var_299_9.gameObject, typeof(DynamicBoneHelper))

				if var_299_10 then
					var_299_10:EnableDynamicBone(false)
				end
			end

			local var_299_11 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_11 then
				var_299_9.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_296_1.time_ - 0) / var_299_11)
				var_299_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_9.position).x, (manager.ui.mainCamera.transform.position - var_299_9.position).y, (manager.ui.mainCamera.transform.position - var_299_9.position).z)
				var_299_9.localEulerAngles.z = 0
				var_299_9.localEulerAngles.x = 0
				var_299_9.localEulerAngles = var_299_9.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_11 and arg_296_1.time_ < 0 + var_299_11 + arg_299_0 then
				var_299_9.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_299_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_9.position).x, (manager.ui.mainCamera.transform.position - var_299_9.position).y, (manager.ui.mainCamera.transform.position - var_299_9.position).z)
				var_299_9.localEulerAngles.z = 0
				var_299_9.localEulerAngles.x = 0
				var_299_9.localEulerAngles = var_299_9.localEulerAngles

				local var_299_12 = GameObjectTools.GetOrAddComponent(var_299_9.gameObject, typeof(DynamicBoneHelper))

				if var_299_12 then
					var_299_12:EnableDynamicBone(true)
				end
			end

			local var_299_13 = arg_296_1.actors_["6046_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_13) and arg_296_1.var_.characterEffect6046_story == nil then
				arg_296_1.var_.characterEffect6046_story = var_299_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_14 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_14 and not isNil(var_299_13) then
				if arg_296_1.var_.characterEffect6046_story and not isNil(var_299_13) then
					arg_296_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_14 and arg_296_1.time_ < 0 + var_299_14 + arg_299_0 and not isNil(var_299_13) and arg_296_1.var_.characterEffect6046_story then
				arg_296_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_299_16 = 0
			local var_299_17 = 0.675

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_18 = arg_296_1:GetWordFromCfg(1109701072)
				local var_299_19 = arg_296_1:FormatText(var_299_18.content)

				arg_296_1.text_.text = var_299_19

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_21 = 27 <= 0 and var_299_17 or var_299_17 * (utf8.len(var_299_19) / 27)

				if (27 <= 0 and var_299_17 or var_299_17 * (utf8.len(var_299_19) / 27)) > 0 and var_299_17 < var_299_21 then
					arg_296_1.talkMaxDuration = var_299_21

					if var_299_21 + var_299_16 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_21 + var_299_16
					end
				end

				arg_296_1.text_.text = var_299_19
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701072", "story_v_side_new_1109701.awb") ~= 0 then
					local var_299_22 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701072", "story_v_side_new_1109701.awb") / 1000

					if var_299_22 + var_299_16 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_22 + var_299_16
					end

					if var_299_18.prefab_name ~= "" and arg_296_1.actors_[var_299_18.prefab_name] ~= nil then
						local var_299_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_18.prefab_name].transform, "story_v_side_new_1109701", "1109701072", "story_v_side_new_1109701.awb")

						arg_296_1:RecordAudio("1109701072", var_299_23)
						arg_296_1:RecordAudio("1109701072", var_299_23)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701072", "story_v_side_new_1109701.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701072", "story_v_side_new_1109701.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_24 = math.max(var_299_17, arg_296_1.talkMaxDuration)

			if var_299_16 <= arg_296_1.time_ and arg_296_1.time_ < var_299_16 + var_299_24 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_16) / var_299_24

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_16 + var_299_24 and arg_296_1.time_ < var_299_16 + var_299_24 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play1109701073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1109701073
		arg_300_1.duration_ = 4.67

		local var_300_0 = {
			zh = 4.666,
			ja = 4.1
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1109701074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos6045_story = arg_300_1.actors_["6045_story"].transform.localPosition

				local var_303_0 = GameObjectTools.GetOrAddComponent(arg_300_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_303_0 then
					var_303_0:EnableDynamicBone(false)
				end
			end

			local var_303_1 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_1 then
				arg_300_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_300_1.time_ - 0) / var_303_1)
				arg_300_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["6045_story"].transform.position).z)
				arg_300_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["6045_story"].transform.localEulerAngles = arg_300_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_1 and arg_300_1.time_ < 0 + var_303_1 + arg_303_0 then
				arg_300_1.actors_["6045_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_300_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["6045_story"].transform.position).z)
				arg_300_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["6045_story"].transform.localEulerAngles = arg_300_1.actors_["6045_story"].transform.localEulerAngles

				local var_303_2 = GameObjectTools.GetOrAddComponent(arg_300_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_303_2 then
					var_303_2:EnableDynamicBone(true)
				end
			end

			local var_303_3 = arg_300_1.actors_["6045_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect6045_story == nil then
				arg_300_1.var_.characterEffect6045_story = var_303_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_4 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 and not isNil(var_303_3) then
				if arg_300_1.var_.characterEffect6045_story and not isNil(var_303_3) then
					arg_300_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect6045_story then
				arg_300_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_303_6 = arg_300_1.actors_["6046_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_6) and arg_300_1.var_.characterEffect6046_story == nil then
				arg_300_1.var_.characterEffect6046_story = var_303_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_7 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 and not isNil(var_303_6) then
				if arg_300_1.var_.characterEffect6046_story and not isNil(var_303_6) then
					arg_300_1.var_.characterEffect6046_story.fillFlat = true
					arg_300_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_7)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 and not isNil(var_303_6) and arg_300_1.var_.characterEffect6046_story then
				arg_300_1.var_.characterEffect6046_story.fillFlat = true
				arg_300_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_303_8 = 0
			local var_303_9 = 0.375

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_8 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_10 = arg_300_1:GetWordFromCfg(1109701073)
				local var_303_11 = arg_300_1:FormatText(var_303_10.content)

				arg_300_1.text_.text = var_303_11

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_13 = 15 <= 0 and var_303_9 or var_303_9 * (utf8.len(var_303_11) / 15)

				if (15 <= 0 and var_303_9 or var_303_9 * (utf8.len(var_303_11) / 15)) > 0 and var_303_9 < var_303_13 then
					arg_300_1.talkMaxDuration = var_303_13

					if var_303_13 + var_303_8 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_13 + var_303_8
					end
				end

				arg_300_1.text_.text = var_303_11
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701073", "story_v_side_new_1109701.awb") ~= 0 then
					local var_303_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701073", "story_v_side_new_1109701.awb") / 1000

					if var_303_14 + var_303_8 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_14 + var_303_8
					end

					if var_303_10.prefab_name ~= "" and arg_300_1.actors_[var_303_10.prefab_name] ~= nil then
						local var_303_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_10.prefab_name].transform, "story_v_side_new_1109701", "1109701073", "story_v_side_new_1109701.awb")

						arg_300_1:RecordAudio("1109701073", var_303_15)
						arg_300_1:RecordAudio("1109701073", var_303_15)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701073", "story_v_side_new_1109701.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701073", "story_v_side_new_1109701.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_16 = math.max(var_303_9, arg_300_1.talkMaxDuration)

			if var_303_8 <= arg_300_1.time_ and arg_300_1.time_ < var_303_8 + var_303_16 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_8) / var_303_16

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_8 + var_303_16 and arg_300_1.time_ < var_303_8 + var_303_16 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play1109701074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1109701074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1109701075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["6045_story"]) and arg_304_1.var_.characterEffect6045_story == nil then
				arg_304_1.var_.characterEffect6045_story = arg_304_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_0 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["6045_story"]) then
				if arg_304_1.var_.characterEffect6045_story and not isNil(arg_304_1.actors_["6045_story"]) then
					arg_304_1.var_.characterEffect6045_story.fillFlat = true
					arg_304_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_304_1.time_ - 0) / var_307_0)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["6045_story"]) and arg_304_1.var_.characterEffect6045_story then
				arg_304_1.var_.characterEffect6045_story.fillFlat = true
				arg_304_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_307_1 = 0
			local var_307_2 = 0.125

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(1109701074).content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 5 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 5)

				if (5 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 5)) > 0 and var_307_2 < var_307_5 then
					arg_304_1.talkMaxDuration = var_307_5

					if var_307_5 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_6 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_6 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_6

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_6 and arg_304_1.time_ < var_307_1 + var_307_6 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1109701075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1109701075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1109701076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos6045_story = arg_308_1.actors_["6045_story"].transform.localPosition

				local var_311_0 = GameObjectTools.GetOrAddComponent(arg_308_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_311_0 then
					var_311_0:EnableDynamicBone(false)
				end
			end

			local var_311_1 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_1 then
				arg_308_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_1)
				arg_308_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["6045_story"].transform.position).z)
				arg_308_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["6045_story"].transform.localEulerAngles = arg_308_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_1 and arg_308_1.time_ < 0 + var_311_1 + arg_311_0 then
				arg_308_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["6045_story"].transform.position).z)
				arg_308_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["6045_story"].transform.localEulerAngles = arg_308_1.actors_["6045_story"].transform.localEulerAngles

				local var_311_2 = GameObjectTools.GetOrAddComponent(arg_308_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_311_2 then
					var_311_2:EnableDynamicBone(true)
				end
			end

			local var_311_3 = arg_308_1.actors_["6045_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_3) and arg_308_1.var_.characterEffect6045_story == nil then
				arg_308_1.var_.characterEffect6045_story = var_311_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_4 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 and not isNil(var_311_3) then
				if arg_308_1.var_.characterEffect6045_story and not isNil(var_311_3) then
					arg_308_1.var_.characterEffect6045_story.fillFlat = true
					arg_308_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_4)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 and not isNil(var_311_3) and arg_308_1.var_.characterEffect6045_story then
				arg_308_1.var_.characterEffect6045_story.fillFlat = true
				arg_308_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_311_5 = arg_308_1.actors_["6046_story"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos6046_story = var_311_5.localPosition

				local var_311_6 = GameObjectTools.GetOrAddComponent(var_311_5.gameObject, typeof(DynamicBoneHelper))

				if var_311_6 then
					var_311_6:EnableDynamicBone(false)
				end
			end

			local var_311_7 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_7 then
				var_311_5.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_7)
				var_311_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_5.position).x, (manager.ui.mainCamera.transform.position - var_311_5.position).y, (manager.ui.mainCamera.transform.position - var_311_5.position).z)
				var_311_5.localEulerAngles.z = 0
				var_311_5.localEulerAngles.x = 0
				var_311_5.localEulerAngles = var_311_5.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_7 and arg_308_1.time_ < 0 + var_311_7 + arg_311_0 then
				var_311_5.localPosition = Vector3.New(0, 100, 0)
				var_311_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_5.position).x, (manager.ui.mainCamera.transform.position - var_311_5.position).y, (manager.ui.mainCamera.transform.position - var_311_5.position).z)
				var_311_5.localEulerAngles.z = 0
				var_311_5.localEulerAngles.x = 0
				var_311_5.localEulerAngles = var_311_5.localEulerAngles

				local var_311_8 = GameObjectTools.GetOrAddComponent(var_311_5.gameObject, typeof(DynamicBoneHelper))

				if var_311_8 then
					var_311_8:EnableDynamicBone(true)
				end
			end

			local var_311_9 = arg_308_1.actors_["6046_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect6046_story == nil then
				arg_308_1.var_.characterEffect6046_story = var_311_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_10 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_10 and not isNil(var_311_9) then
				if arg_308_1.var_.characterEffect6046_story and not isNil(var_311_9) then
					arg_308_1.var_.characterEffect6046_story.fillFlat = true
					arg_308_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_10)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_10 and arg_308_1.time_ < 0 + var_311_10 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect6046_story then
				arg_308_1.var_.characterEffect6046_story.fillFlat = true
				arg_308_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_311_11 = 0
			local var_311_12 = 0.625

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_11 + arg_311_0 then
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

				local var_311_13 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(1109701075).content)

				arg_308_1.text_.text = var_311_13

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_15 = 25 <= 0 and var_311_12 or var_311_12 * (utf8.len(var_311_13) / 25)

				if (25 <= 0 and var_311_12 or var_311_12 * (utf8.len(var_311_13) / 25)) > 0 and var_311_12 < var_311_15 then
					arg_308_1.talkMaxDuration = var_311_15

					if var_311_15 + var_311_11 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_15 + var_311_11
					end
				end

				arg_308_1.text_.text = var_311_13
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_16 = math.max(var_311_12, arg_308_1.talkMaxDuration)

			if var_311_11 <= arg_308_1.time_ and arg_308_1.time_ < var_311_11 + var_311_16 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_11) / var_311_16

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_11 + var_311_16 and arg_308_1.time_ < var_311_11 + var_311_16 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play1109701076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1109701076
		arg_312_1.duration_ = 6.63

		local var_312_0 = {
			zh = 5.066,
			ja = 6.633
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
				arg_312_0:Play1109701077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1097ui_story = arg_312_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_315_0 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 then
				arg_312_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_312_1.time_ - 0) / var_315_0)
				arg_312_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).z)
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles = arg_312_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 then
				arg_312_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_312_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).z)
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles = arg_312_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_315_1 = arg_312_1.actors_["1097ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1097ui_story == nil then
				arg_312_1.var_.characterEffect1097ui_story = var_315_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_2 and not isNil(var_315_1) then
				if arg_312_1.var_.characterEffect1097ui_story and not isNil(var_315_1) then
					arg_312_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_2 and arg_312_1.time_ < 0 + var_315_2 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1097ui_story then
				arg_312_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_315_4 = 0
			local var_315_5 = 0.675

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_6 = arg_312_1:GetWordFromCfg(1109701076)
				local var_315_7 = arg_312_1:FormatText(var_315_6.content)

				arg_312_1.text_.text = var_315_7

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_9 = 27 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 27)

				if (27 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 27)) > 0 and var_315_5 < var_315_9 then
					arg_312_1.talkMaxDuration = var_315_9

					if var_315_9 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_9 + var_315_4
					end
				end

				arg_312_1.text_.text = var_315_7
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701076", "story_v_side_new_1109701.awb") ~= 0 then
					local var_315_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701076", "story_v_side_new_1109701.awb") / 1000

					if var_315_10 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_10 + var_315_4
					end

					if var_315_6.prefab_name ~= "" and arg_312_1.actors_[var_315_6.prefab_name] ~= nil then
						local var_315_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_6.prefab_name].transform, "story_v_side_new_1109701", "1109701076", "story_v_side_new_1109701.awb")

						arg_312_1:RecordAudio("1109701076", var_315_11)
						arg_312_1:RecordAudio("1109701076", var_315_11)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701076", "story_v_side_new_1109701.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701076", "story_v_side_new_1109701.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_12 = math.max(var_315_5, arg_312_1.talkMaxDuration)

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_12 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_4) / var_315_12

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_4 + var_315_12 and arg_312_1.time_ < var_315_4 + var_315_12 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play1109701077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1109701077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1109701078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["1097ui_story"]) and arg_316_1.var_.characterEffect1097ui_story == nil then
				arg_316_1.var_.characterEffect1097ui_story = arg_316_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_0 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["1097ui_story"]) then
				if arg_316_1.var_.characterEffect1097ui_story and not isNil(arg_316_1.actors_["1097ui_story"]) then
					arg_316_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_0)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["1097ui_story"]) and arg_316_1.var_.characterEffect1097ui_story then
				arg_316_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_319_1 = 0
			local var_319_2 = 0.1

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
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

				local var_319_3 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(1109701077).content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 4 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 4)

				if (4 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 4)) > 0 and var_319_2 < var_319_5 then
					arg_316_1.talkMaxDuration = var_319_5

					if var_319_5 + var_319_1 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + var_319_1
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_6 = math.max(var_319_2, arg_316_1.talkMaxDuration)

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_6 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_1) / var_319_6

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_1 + var_319_6 and arg_316_1.time_ < var_319_1 + var_319_6 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1109701078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1109701078
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1109701079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.95

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(1109701078).content)

				arg_320_1.text_.text = var_323_1

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_3 = 38 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 38)

				if (38 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 38)) > 0 and var_323_0 < var_323_3 then
					arg_320_1.talkMaxDuration = var_323_3

					if var_323_3 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_3 + 0
					end
				end

				arg_320_1.text_.text = var_323_1
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_4 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_4

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1109701079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1109701079
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1109701080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0.325

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_1 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(1109701079).content)

				arg_324_1.text_.text = var_327_1

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_3 = 13 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 13)

				if (13 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 13)) > 0 and var_327_0 < var_327_3 then
					arg_324_1.talkMaxDuration = var_327_3

					if var_327_3 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_3 + 0
					end
				end

				arg_324_1.text_.text = var_327_1
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_4 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_4

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1109701080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1109701080
		arg_328_1.duration_ = 7

		local var_328_0 = {
			zh = 6.133,
			ja = 7
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1109701081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["1097ui_story"]) and arg_328_1.var_.characterEffect1097ui_story == nil then
				arg_328_1.var_.characterEffect1097ui_story = arg_328_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_0 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["1097ui_story"]) then
				if arg_328_1.var_.characterEffect1097ui_story and not isNil(arg_328_1.actors_["1097ui_story"]) then
					arg_328_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["1097ui_story"]) and arg_328_1.var_.characterEffect1097ui_story then
				arg_328_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_331_2 = 0
			local var_331_3 = 0.45

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_2 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_4 = arg_328_1:GetWordFromCfg(1109701080)
				local var_331_5 = arg_328_1:FormatText(var_331_4.content)

				arg_328_1.text_.text = var_331_5

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_7 = 18 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_5) / 18)

				if (18 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_5) / 18)) > 0 and var_331_3 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_2
					end
				end

				arg_328_1.text_.text = var_331_5
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701080", "story_v_side_new_1109701.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701080", "story_v_side_new_1109701.awb") / 1000

					if var_331_8 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_2
					end

					if var_331_4.prefab_name ~= "" and arg_328_1.actors_[var_331_4.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_4.prefab_name].transform, "story_v_side_new_1109701", "1109701080", "story_v_side_new_1109701.awb")

						arg_328_1:RecordAudio("1109701080", var_331_9)
						arg_328_1:RecordAudio("1109701080", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701080", "story_v_side_new_1109701.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701080", "story_v_side_new_1109701.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_3, arg_328_1.talkMaxDuration)

			if var_331_2 <= arg_328_1.time_ and arg_328_1.time_ < var_331_2 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_2) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_2 + var_331_10 and arg_328_1.time_ < var_331_2 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1109701081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1109701081
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1109701082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["1097ui_story"]) and arg_332_1.var_.characterEffect1097ui_story == nil then
				arg_332_1.var_.characterEffect1097ui_story = arg_332_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_0 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["1097ui_story"]) then
				if arg_332_1.var_.characterEffect1097ui_story and not isNil(arg_332_1.actors_["1097ui_story"]) then
					arg_332_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_332_1.time_ - 0) / var_335_0)
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["1097ui_story"]) and arg_332_1.var_.characterEffect1097ui_story then
				arg_332_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_335_1 = 0
			local var_335_2 = 0.2

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_3 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(1109701081).content)

				arg_332_1.text_.text = var_335_3

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 8 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_3) / 8)

				if (8 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_3) / 8)) > 0 and var_335_2 < var_335_5 then
					arg_332_1.talkMaxDuration = var_335_5

					if var_335_5 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + var_335_1
					end
				end

				arg_332_1.text_.text = var_335_3
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_6 = math.max(var_335_2, arg_332_1.talkMaxDuration)

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_6 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_1) / var_335_6

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_1 + var_335_6 and arg_332_1.time_ < var_335_1 + var_335_6 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play1109701082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1109701082
		arg_336_1.duration_ = 8.8

		local var_336_0 = {
			zh = 7.1,
			ja = 8.8
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
				arg_336_0:Play1109701083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1097ui_story = arg_336_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_339_0 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 then
				arg_336_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_336_1.time_ - 0) / var_339_0)
				arg_336_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1097ui_story"].transform.position).z)
				arg_336_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1097ui_story"].transform.localEulerAngles = arg_336_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 then
				arg_336_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_336_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1097ui_story"].transform.position).z)
				arg_336_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1097ui_story"].transform.localEulerAngles = arg_336_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_339_1 = arg_336_1.actors_["1097ui_story"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_1) and arg_336_1.var_.characterEffect1097ui_story == nil then
				arg_336_1.var_.characterEffect1097ui_story = var_339_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_2 and not isNil(var_339_1) then
				if arg_336_1.var_.characterEffect1097ui_story and not isNil(var_339_1) then
					arg_336_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 0 + var_339_2 and arg_336_1.time_ < 0 + var_339_2 + arg_339_0 and not isNil(var_339_1) and arg_336_1.var_.characterEffect1097ui_story then
				arg_336_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_339_4 = 0
			local var_339_5 = 0.525

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_6 = arg_336_1:GetWordFromCfg(1109701082)
				local var_339_7 = arg_336_1:FormatText(var_339_6.content)

				arg_336_1.text_.text = var_339_7

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_9 = 21 <= 0 and var_339_5 or var_339_5 * (utf8.len(var_339_7) / 21)

				if (21 <= 0 and var_339_5 or var_339_5 * (utf8.len(var_339_7) / 21)) > 0 and var_339_5 < var_339_9 then
					arg_336_1.talkMaxDuration = var_339_9

					if var_339_9 + var_339_4 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_9 + var_339_4
					end
				end

				arg_336_1.text_.text = var_339_7
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701082", "story_v_side_new_1109701.awb") ~= 0 then
					local var_339_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701082", "story_v_side_new_1109701.awb") / 1000

					if var_339_10 + var_339_4 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_10 + var_339_4
					end

					if var_339_6.prefab_name ~= "" and arg_336_1.actors_[var_339_6.prefab_name] ~= nil then
						local var_339_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_6.prefab_name].transform, "story_v_side_new_1109701", "1109701082", "story_v_side_new_1109701.awb")

						arg_336_1:RecordAudio("1109701082", var_339_11)
						arg_336_1:RecordAudio("1109701082", var_339_11)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701082", "story_v_side_new_1109701.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701082", "story_v_side_new_1109701.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_12 = math.max(var_339_5, arg_336_1.talkMaxDuration)

			if var_339_4 <= arg_336_1.time_ and arg_336_1.time_ < var_339_4 + var_339_12 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_4) / var_339_12

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_4 + var_339_12 and arg_336_1.time_ < var_339_4 + var_339_12 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play1109701083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1109701083
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1109701084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["1097ui_story"]) and arg_340_1.var_.characterEffect1097ui_story == nil then
				arg_340_1.var_.characterEffect1097ui_story = arg_340_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_0 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["1097ui_story"]) then
				if arg_340_1.var_.characterEffect1097ui_story and not isNil(arg_340_1.actors_["1097ui_story"]) then
					arg_340_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_340_1.time_ - 0) / var_343_0)
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["1097ui_story"]) and arg_340_1.var_.characterEffect1097ui_story then
				arg_340_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_343_1 = 0
			local var_343_2 = 0.625

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_3 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(1109701083).content)

				arg_340_1.text_.text = var_343_3

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 25 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_3) / 25)

				if (25 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_3) / 25)) > 0 and var_343_2 < var_343_5 then
					arg_340_1.talkMaxDuration = var_343_5

					if var_343_5 + var_343_1 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + var_343_1
					end
				end

				arg_340_1.text_.text = var_343_3
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_6 = math.max(var_343_2, arg_340_1.talkMaxDuration)

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_6 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_1) / var_343_6

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_1 + var_343_6 and arg_340_1.time_ < var_343_1 + var_343_6 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1109701084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1109701084
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1109701085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.525

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
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

				local var_347_1 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(1109701084).content)

				arg_344_1.text_.text = var_347_1

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_3 = 21 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_1) / 21)

				if (21 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_1) / 21)) > 0 and var_347_0 < var_347_3 then
					arg_344_1.talkMaxDuration = var_347_3

					if var_347_3 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_3 + 0
					end
				end

				arg_344_1.text_.text = var_347_1
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_4 = math.max(var_347_0, arg_344_1.talkMaxDuration)

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_4 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - 0) / var_347_4

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= 0 + var_347_4 and arg_344_1.time_ < 0 + var_347_4 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1109701085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1109701085
		arg_348_1.duration_ = 10.33

		local var_348_0 = {
			zh = 8,
			ja = 10.333
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1109701086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos1097ui_story = arg_348_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_351_0 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 then
				arg_348_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_348_1.time_ - 0) / var_351_0)
				arg_348_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1097ui_story"].transform.position).z)
				arg_348_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1097ui_story"].transform.localEulerAngles = arg_348_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 then
				arg_348_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_348_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1097ui_story"].transform.position).z)
				arg_348_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1097ui_story"].transform.localEulerAngles = arg_348_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_351_1 = arg_348_1.actors_["1097ui_story"]

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(var_351_1) and arg_348_1.var_.characterEffect1097ui_story == nil then
				arg_348_1.var_.characterEffect1097ui_story = var_351_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_2 and not isNil(var_351_1) then
				if arg_348_1.var_.characterEffect1097ui_story and not isNil(var_351_1) then
					arg_348_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= 0 + var_351_2 and arg_348_1.time_ < 0 + var_351_2 + arg_351_0 and not isNil(var_351_1) and arg_348_1.var_.characterEffect1097ui_story then
				arg_348_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_351_4 = 0
			local var_351_5 = 0.7

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_6 = arg_348_1:GetWordFromCfg(1109701085)
				local var_351_7 = arg_348_1:FormatText(var_351_6.content)

				arg_348_1.text_.text = var_351_7

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_9 = 28 <= 0 and var_351_5 or var_351_5 * (utf8.len(var_351_7) / 28)

				if (28 <= 0 and var_351_5 or var_351_5 * (utf8.len(var_351_7) / 28)) > 0 and var_351_5 < var_351_9 then
					arg_348_1.talkMaxDuration = var_351_9

					if var_351_9 + var_351_4 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_9 + var_351_4
					end
				end

				arg_348_1.text_.text = var_351_7
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701085", "story_v_side_new_1109701.awb") ~= 0 then
					local var_351_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701085", "story_v_side_new_1109701.awb") / 1000

					if var_351_10 + var_351_4 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_10 + var_351_4
					end

					if var_351_6.prefab_name ~= "" and arg_348_1.actors_[var_351_6.prefab_name] ~= nil then
						local var_351_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_6.prefab_name].transform, "story_v_side_new_1109701", "1109701085", "story_v_side_new_1109701.awb")

						arg_348_1:RecordAudio("1109701085", var_351_11)
						arg_348_1:RecordAudio("1109701085", var_351_11)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701085", "story_v_side_new_1109701.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701085", "story_v_side_new_1109701.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_12 = math.max(var_351_5, arg_348_1.talkMaxDuration)

			if var_351_4 <= arg_348_1.time_ and arg_348_1.time_ < var_351_4 + var_351_12 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_4) / var_351_12

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_4 + var_351_12 and arg_348_1.time_ < var_351_4 + var_351_12 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play1109701086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1109701086
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1109701087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1097ui_story"]) and arg_352_1.var_.characterEffect1097ui_story == nil then
				arg_352_1.var_.characterEffect1097ui_story = arg_352_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1097ui_story"]) then
				if arg_352_1.var_.characterEffect1097ui_story and not isNil(arg_352_1.actors_["1097ui_story"]) then
					arg_352_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_0)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1097ui_story"]) and arg_352_1.var_.characterEffect1097ui_story then
				arg_352_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_355_1 = 0
			local var_355_2 = 0.6

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(1109701086).content)

				arg_352_1.text_.text = var_355_3

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 24 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 24)

				if (24 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 24)) > 0 and var_355_2 < var_355_5 then
					arg_352_1.talkMaxDuration = var_355_5

					if var_355_5 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_3
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_6 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_6 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_6

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_6 and arg_352_1.time_ < var_355_1 + var_355_6 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1109701087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1109701087
		arg_356_1.duration_ = 5.1

		local var_356_0 = {
			zh = 3.833,
			ja = 5.1
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1109701088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["1097ui_story"]) and arg_356_1.var_.characterEffect1097ui_story == nil then
				arg_356_1.var_.characterEffect1097ui_story = arg_356_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["1097ui_story"]) then
				if arg_356_1.var_.characterEffect1097ui_story and not isNil(arg_356_1.actors_["1097ui_story"]) then
					arg_356_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["1097ui_story"]) and arg_356_1.var_.characterEffect1097ui_story then
				arg_356_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_359_2 = 0
			local var_359_3 = 0.325

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_2 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_4 = arg_356_1:GetWordFromCfg(1109701087)
				local var_359_5 = arg_356_1:FormatText(var_359_4.content)

				arg_356_1.text_.text = var_359_5

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_7 = 13 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 13)

				if (13 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 13)) > 0 and var_359_3 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_2
					end
				end

				arg_356_1.text_.text = var_359_5
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701087", "story_v_side_new_1109701.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701087", "story_v_side_new_1109701.awb") / 1000

					if var_359_8 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_2
					end

					if var_359_4.prefab_name ~= "" and arg_356_1.actors_[var_359_4.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_4.prefab_name].transform, "story_v_side_new_1109701", "1109701087", "story_v_side_new_1109701.awb")

						arg_356_1:RecordAudio("1109701087", var_359_9)
						arg_356_1:RecordAudio("1109701087", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701087", "story_v_side_new_1109701.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701087", "story_v_side_new_1109701.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_3, arg_356_1.talkMaxDuration)

			if var_359_2 <= arg_356_1.time_ and arg_356_1.time_ < var_359_2 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_2) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_2 + var_359_10 and arg_356_1.time_ < var_359_2 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1109701088 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1109701088
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1109701089(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["1097ui_story"]) and arg_360_1.var_.characterEffect1097ui_story == nil then
				arg_360_1.var_.characterEffect1097ui_story = arg_360_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_0 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["1097ui_story"]) then
				if arg_360_1.var_.characterEffect1097ui_story and not isNil(arg_360_1.actors_["1097ui_story"]) then
					arg_360_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_360_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_360_1.time_ - 0) / var_363_0)
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["1097ui_story"]) and arg_360_1.var_.characterEffect1097ui_story then
				arg_360_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_360_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_363_1 = 0
			local var_363_2 = 0.85

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_3 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(1109701088).content)

				arg_360_1.text_.text = var_363_3

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 34 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_3) / 34)

				if (34 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_3) / 34)) > 0 and var_363_2 < var_363_5 then
					arg_360_1.talkMaxDuration = var_363_5

					if var_363_5 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + var_363_1
					end
				end

				arg_360_1.text_.text = var_363_3
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_6 = math.max(var_363_2, arg_360_1.talkMaxDuration)

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_6 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_1) / var_363_6

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_1 + var_363_6 and arg_360_1.time_ < var_363_1 + var_363_6 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1109701089 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1109701089
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1109701090(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.825

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_1 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(1109701089).content)

				arg_364_1.text_.text = var_367_1

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_3 = 33 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 33)

				if (33 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 33)) > 0 and var_367_0 < var_367_3 then
					arg_364_1.talkMaxDuration = var_367_3

					if var_367_3 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_3 + 0
					end
				end

				arg_364_1.text_.text = var_367_1
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_4 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_4 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_4

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_4 and arg_364_1.time_ < 0 + var_367_4 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1109701090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1109701090
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1109701091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.8

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_1 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(1109701090).content)

				arg_368_1.text_.text = var_371_1

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_3 = 32 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_1) / 32)

				if (32 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_1) / 32)) > 0 and var_371_0 < var_371_3 then
					arg_368_1.talkMaxDuration = var_371_3

					if var_371_3 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_3 + 0
					end
				end

				arg_368_1.text_.text = var_371_1
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_4 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_4 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_4

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_4 and arg_368_1.time_ < 0 + var_371_4 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play1109701091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1109701091
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1109701092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0.575

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(1109701091).content)

				arg_372_1.text_.text = var_375_1

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_3 = 23 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 23)

				if (23 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 23)) > 0 and var_375_0 < var_375_3 then
					arg_372_1.talkMaxDuration = var_375_3

					if var_375_3 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_3 + 0
					end
				end

				arg_372_1.text_.text = var_375_1
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_4 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_4 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_4

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_4 and arg_372_1.time_ < 0 + var_375_4 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1109701092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1109701092
		arg_376_1.duration_ = 5.8

		local var_376_0 = {
			zh = 4.433,
			ja = 5.8
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1109701093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos1097ui_story = arg_376_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_379_0 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 then
				arg_376_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_376_1.time_ - 0) / var_379_0)
				arg_376_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1097ui_story"].transform.position).z)
				arg_376_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1097ui_story"].transform.localEulerAngles = arg_376_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 then
				arg_376_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_376_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1097ui_story"].transform.position).z)
				arg_376_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1097ui_story"].transform.localEulerAngles = arg_376_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_379_1 = arg_376_1.actors_["1097ui_story"]

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(var_379_1) and arg_376_1.var_.characterEffect1097ui_story == nil then
				arg_376_1.var_.characterEffect1097ui_story = var_379_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_2 and not isNil(var_379_1) then
				if arg_376_1.var_.characterEffect1097ui_story and not isNil(var_379_1) then
					arg_376_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= 0 + var_379_2 and arg_376_1.time_ < 0 + var_379_2 + arg_379_0 and not isNil(var_379_1) and arg_376_1.var_.characterEffect1097ui_story then
				arg_376_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_379_4 = 0
			local var_379_5 = 0.4

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_4 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_6 = arg_376_1:GetWordFromCfg(1109701092)
				local var_379_7 = arg_376_1:FormatText(var_379_6.content)

				arg_376_1.text_.text = var_379_7

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_9 = 16 <= 0 and var_379_5 or var_379_5 * (utf8.len(var_379_7) / 16)

				if (16 <= 0 and var_379_5 or var_379_5 * (utf8.len(var_379_7) / 16)) > 0 and var_379_5 < var_379_9 then
					arg_376_1.talkMaxDuration = var_379_9

					if var_379_9 + var_379_4 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_9 + var_379_4
					end
				end

				arg_376_1.text_.text = var_379_7
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701092", "story_v_side_new_1109701.awb") ~= 0 then
					local var_379_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701092", "story_v_side_new_1109701.awb") / 1000

					if var_379_10 + var_379_4 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_10 + var_379_4
					end

					if var_379_6.prefab_name ~= "" and arg_376_1.actors_[var_379_6.prefab_name] ~= nil then
						local var_379_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_6.prefab_name].transform, "story_v_side_new_1109701", "1109701092", "story_v_side_new_1109701.awb")

						arg_376_1:RecordAudio("1109701092", var_379_11)
						arg_376_1:RecordAudio("1109701092", var_379_11)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701092", "story_v_side_new_1109701.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701092", "story_v_side_new_1109701.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_12 = math.max(var_379_5, arg_376_1.talkMaxDuration)

			if var_379_4 <= arg_376_1.time_ and arg_376_1.time_ < var_379_4 + var_379_12 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_4) / var_379_12

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_4 + var_379_12 and arg_376_1.time_ < var_379_4 + var_379_12 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play1109701093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1109701093
		arg_380_1.duration_ = 7.1

		local var_380_0 = {
			zh = 7.1,
			ja = 6.1
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1109701094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos1097ui_story = arg_380_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_383_0 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 then
				arg_380_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_380_1.time_ - 0) / var_383_0)
				arg_380_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1097ui_story"].transform.position).z)
				arg_380_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1097ui_story"].transform.localEulerAngles = arg_380_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 then
				arg_380_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_380_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1097ui_story"].transform.position).z)
				arg_380_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1097ui_story"].transform.localEulerAngles = arg_380_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_383_1 = arg_380_1.actors_["1097ui_story"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_1) and arg_380_1.var_.characterEffect1097ui_story == nil then
				arg_380_1.var_.characterEffect1097ui_story = var_383_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_2 and not isNil(var_383_1) then
				if arg_380_1.var_.characterEffect1097ui_story and not isNil(var_383_1) then
					arg_380_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_2)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_2 and arg_380_1.time_ < 0 + var_383_2 + arg_383_0 and not isNil(var_383_1) and arg_380_1.var_.characterEffect1097ui_story then
				arg_380_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_383_3 = arg_380_1.actors_["6045_story"].transform

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos6045_story = var_383_3.localPosition

				local var_383_4 = GameObjectTools.GetOrAddComponent(var_383_3.gameObject, typeof(DynamicBoneHelper))

				if var_383_4 then
					var_383_4:EnableDynamicBone(false)
				end
			end

			local var_383_5 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_5 then
				var_383_3.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_380_1.time_ - 0) / var_383_5)
				var_383_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_3.position).x, (manager.ui.mainCamera.transform.position - var_383_3.position).y, (manager.ui.mainCamera.transform.position - var_383_3.position).z)
				var_383_3.localEulerAngles.z = 0
				var_383_3.localEulerAngles.x = 0
				var_383_3.localEulerAngles = var_383_3.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_5 and arg_380_1.time_ < 0 + var_383_5 + arg_383_0 then
				var_383_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_383_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_3.position).x, (manager.ui.mainCamera.transform.position - var_383_3.position).y, (manager.ui.mainCamera.transform.position - var_383_3.position).z)
				var_383_3.localEulerAngles.z = 0
				var_383_3.localEulerAngles.x = 0
				var_383_3.localEulerAngles = var_383_3.localEulerAngles

				local var_383_6 = GameObjectTools.GetOrAddComponent(var_383_3.gameObject, typeof(DynamicBoneHelper))

				if var_383_6 then
					var_383_6:EnableDynamicBone(true)
				end
			end

			local var_383_7 = arg_380_1.actors_["6045_story"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_7) and arg_380_1.var_.characterEffect6045_story == nil then
				arg_380_1.var_.characterEffect6045_story = var_383_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_8 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_8 and not isNil(var_383_7) then
				if arg_380_1.var_.characterEffect6045_story and not isNil(var_383_7) then
					arg_380_1.var_.characterEffect6045_story.fillFlat = true
					arg_380_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_8)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_8 and arg_380_1.time_ < 0 + var_383_8 + arg_383_0 and not isNil(var_383_7) and arg_380_1.var_.characterEffect6045_story then
				arg_380_1.var_.characterEffect6045_story.fillFlat = true
				arg_380_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_383_9 = arg_380_1.actors_["6046_story"].transform

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos6046_story = var_383_9.localPosition

				local var_383_10 = GameObjectTools.GetOrAddComponent(var_383_9.gameObject, typeof(DynamicBoneHelper))

				if var_383_10 then
					var_383_10:EnableDynamicBone(false)
				end
			end

			local var_383_11 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_11 then
				var_383_9.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_380_1.time_ - 0) / var_383_11)
				var_383_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_9.position).x, (manager.ui.mainCamera.transform.position - var_383_9.position).y, (manager.ui.mainCamera.transform.position - var_383_9.position).z)
				var_383_9.localEulerAngles.z = 0
				var_383_9.localEulerAngles.x = 0
				var_383_9.localEulerAngles = var_383_9.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_11 and arg_380_1.time_ < 0 + var_383_11 + arg_383_0 then
				var_383_9.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_383_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_9.position).x, (manager.ui.mainCamera.transform.position - var_383_9.position).y, (manager.ui.mainCamera.transform.position - var_383_9.position).z)
				var_383_9.localEulerAngles.z = 0
				var_383_9.localEulerAngles.x = 0
				var_383_9.localEulerAngles = var_383_9.localEulerAngles

				local var_383_12 = GameObjectTools.GetOrAddComponent(var_383_9.gameObject, typeof(DynamicBoneHelper))

				if var_383_12 then
					var_383_12:EnableDynamicBone(true)
				end
			end

			local var_383_13 = arg_380_1.actors_["6046_story"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_13) and arg_380_1.var_.characterEffect6046_story == nil then
				arg_380_1.var_.characterEffect6046_story = var_383_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_14 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_14 and not isNil(var_383_13) then
				if arg_380_1.var_.characterEffect6046_story and not isNil(var_383_13) then
					arg_380_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= 0 + var_383_14 and arg_380_1.time_ < 0 + var_383_14 + arg_383_0 and not isNil(var_383_13) and arg_380_1.var_.characterEffect6046_story then
				arg_380_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			local var_383_16 = 0
			local var_383_17 = 0.675

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_16 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_18 = arg_380_1:GetWordFromCfg(1109701093)
				local var_383_19 = arg_380_1:FormatText(var_383_18.content)

				arg_380_1.text_.text = var_383_19

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_21 = 27 <= 0 and var_383_17 or var_383_17 * (utf8.len(var_383_19) / 27)

				if (27 <= 0 and var_383_17 or var_383_17 * (utf8.len(var_383_19) / 27)) > 0 and var_383_17 < var_383_21 then
					arg_380_1.talkMaxDuration = var_383_21

					if var_383_21 + var_383_16 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_21 + var_383_16
					end
				end

				arg_380_1.text_.text = var_383_19
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701093", "story_v_side_new_1109701.awb") ~= 0 then
					local var_383_22 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701093", "story_v_side_new_1109701.awb") / 1000

					if var_383_22 + var_383_16 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_22 + var_383_16
					end

					if var_383_18.prefab_name ~= "" and arg_380_1.actors_[var_383_18.prefab_name] ~= nil then
						local var_383_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_18.prefab_name].transform, "story_v_side_new_1109701", "1109701093", "story_v_side_new_1109701.awb")

						arg_380_1:RecordAudio("1109701093", var_383_23)
						arg_380_1:RecordAudio("1109701093", var_383_23)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701093", "story_v_side_new_1109701.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701093", "story_v_side_new_1109701.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_24 = math.max(var_383_17, arg_380_1.talkMaxDuration)

			if var_383_16 <= arg_380_1.time_ and arg_380_1.time_ < var_383_16 + var_383_24 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_16) / var_383_24

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_16 + var_383_24 and arg_380_1.time_ < var_383_16 + var_383_24 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play1109701094 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1109701094
		arg_384_1.duration_ = 5.67

		local var_384_0 = {
			zh = 5.666,
			ja = 3.966
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1109701095(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos6045_story = arg_384_1.actors_["6045_story"].transform.localPosition

				local var_387_0 = GameObjectTools.GetOrAddComponent(arg_384_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_387_0 then
					var_387_0:EnableDynamicBone(false)
				end
			end

			local var_387_1 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_1 then
				arg_384_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_384_1.time_ - 0) / var_387_1)
				arg_384_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["6045_story"].transform.position).z)
				arg_384_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["6045_story"].transform.localEulerAngles = arg_384_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_1 and arg_384_1.time_ < 0 + var_387_1 + arg_387_0 then
				arg_384_1.actors_["6045_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_384_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["6045_story"].transform.position).z)
				arg_384_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["6045_story"].transform.localEulerAngles = arg_384_1.actors_["6045_story"].transform.localEulerAngles

				local var_387_2 = GameObjectTools.GetOrAddComponent(arg_384_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_387_2 then
					var_387_2:EnableDynamicBone(true)
				end
			end

			local var_387_3 = arg_384_1.actors_["6045_story"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_3) and arg_384_1.var_.characterEffect6045_story == nil then
				arg_384_1.var_.characterEffect6045_story = var_387_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_4 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_4 and not isNil(var_387_3) then
				if arg_384_1.var_.characterEffect6045_story and not isNil(var_387_3) then
					arg_384_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= 0 + var_387_4 and arg_384_1.time_ < 0 + var_387_4 + arg_387_0 and not isNil(var_387_3) and arg_384_1.var_.characterEffect6045_story then
				arg_384_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_387_6 = arg_384_1.actors_["6046_story"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_6) and arg_384_1.var_.characterEffect6046_story == nil then
				arg_384_1.var_.characterEffect6046_story = var_387_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_7 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_7 and not isNil(var_387_6) then
				if arg_384_1.var_.characterEffect6046_story and not isNil(var_387_6) then
					arg_384_1.var_.characterEffect6046_story.fillFlat = true
					arg_384_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_384_1.time_ - 0) / var_387_7)
				end
			end

			if arg_384_1.time_ >= 0 + var_387_7 and arg_384_1.time_ < 0 + var_387_7 + arg_387_0 and not isNil(var_387_6) and arg_384_1.var_.characterEffect6046_story then
				arg_384_1.var_.characterEffect6046_story.fillFlat = true
				arg_384_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_387_8 = 0
			local var_387_9 = 0.45

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_8 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_10 = arg_384_1:GetWordFromCfg(1109701094)
				local var_387_11 = arg_384_1:FormatText(var_387_10.content)

				arg_384_1.text_.text = var_387_11

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_13 = 18 <= 0 and var_387_9 or var_387_9 * (utf8.len(var_387_11) / 18)

				if (18 <= 0 and var_387_9 or var_387_9 * (utf8.len(var_387_11) / 18)) > 0 and var_387_9 < var_387_13 then
					arg_384_1.talkMaxDuration = var_387_13

					if var_387_13 + var_387_8 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_13 + var_387_8
					end
				end

				arg_384_1.text_.text = var_387_11
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701094", "story_v_side_new_1109701.awb") ~= 0 then
					local var_387_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701094", "story_v_side_new_1109701.awb") / 1000

					if var_387_14 + var_387_8 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_14 + var_387_8
					end

					if var_387_10.prefab_name ~= "" and arg_384_1.actors_[var_387_10.prefab_name] ~= nil then
						local var_387_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_10.prefab_name].transform, "story_v_side_new_1109701", "1109701094", "story_v_side_new_1109701.awb")

						arg_384_1:RecordAudio("1109701094", var_387_15)
						arg_384_1:RecordAudio("1109701094", var_387_15)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701094", "story_v_side_new_1109701.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701094", "story_v_side_new_1109701.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_16 = math.max(var_387_9, arg_384_1.talkMaxDuration)

			if var_387_8 <= arg_384_1.time_ and arg_384_1.time_ < var_387_8 + var_387_16 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_8) / var_387_16

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_8 + var_387_16 and arg_384_1.time_ < var_387_8 + var_387_16 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play1109701095 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1109701095
		arg_388_1.duration_ = 2

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1109701096(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos6045_story = arg_388_1.actors_["6045_story"].transform.localPosition

				local var_391_0 = GameObjectTools.GetOrAddComponent(arg_388_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_391_0 then
					var_391_0:EnableDynamicBone(false)
				end
			end

			local var_391_1 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_1 then
				arg_388_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_388_1.time_ - 0) / var_391_1)
				arg_388_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["6045_story"].transform.position).z)
				arg_388_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["6045_story"].transform.localEulerAngles = arg_388_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_1 and arg_388_1.time_ < 0 + var_391_1 + arg_391_0 then
				arg_388_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_388_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["6045_story"].transform.position).z)
				arg_388_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["6045_story"].transform.localEulerAngles = arg_388_1.actors_["6045_story"].transform.localEulerAngles

				local var_391_2 = GameObjectTools.GetOrAddComponent(arg_388_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_391_2 then
					var_391_2:EnableDynamicBone(true)
				end
			end

			local var_391_3 = arg_388_1.actors_["6045_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_3) and arg_388_1.var_.characterEffect6045_story == nil then
				arg_388_1.var_.characterEffect6045_story = var_391_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_4 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_4 and not isNil(var_391_3) then
				if arg_388_1.var_.characterEffect6045_story and not isNil(var_391_3) then
					arg_388_1.var_.characterEffect6045_story.fillFlat = true
					arg_388_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 0) / var_391_4)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_4 and arg_388_1.time_ < 0 + var_391_4 + arg_391_0 and not isNil(var_391_3) and arg_388_1.var_.characterEffect6045_story then
				arg_388_1.var_.characterEffect6045_story.fillFlat = true
				arg_388_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_391_5 = arg_388_1.actors_["6046_story"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos6046_story = var_391_5.localPosition

				local var_391_6 = GameObjectTools.GetOrAddComponent(var_391_5.gameObject, typeof(DynamicBoneHelper))

				if var_391_6 then
					var_391_6:EnableDynamicBone(false)
				end
			end

			local var_391_7 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_7 then
				var_391_5.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_388_1.time_ - 0) / var_391_7)
				var_391_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_5.position).x, (manager.ui.mainCamera.transform.position - var_391_5.position).y, (manager.ui.mainCamera.transform.position - var_391_5.position).z)
				var_391_5.localEulerAngles.z = 0
				var_391_5.localEulerAngles.x = 0
				var_391_5.localEulerAngles = var_391_5.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_7 and arg_388_1.time_ < 0 + var_391_7 + arg_391_0 then
				var_391_5.localPosition = Vector3.New(0, 100, 0)
				var_391_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_5.position).x, (manager.ui.mainCamera.transform.position - var_391_5.position).y, (manager.ui.mainCamera.transform.position - var_391_5.position).z)
				var_391_5.localEulerAngles.z = 0
				var_391_5.localEulerAngles.x = 0
				var_391_5.localEulerAngles = var_391_5.localEulerAngles

				local var_391_8 = GameObjectTools.GetOrAddComponent(var_391_5.gameObject, typeof(DynamicBoneHelper))

				if var_391_8 then
					var_391_8:EnableDynamicBone(true)
				end
			end

			local var_391_9 = arg_388_1.actors_["6046_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect6046_story == nil then
				arg_388_1.var_.characterEffect6046_story = var_391_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_10 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_10 and not isNil(var_391_9) then
				if arg_388_1.var_.characterEffect6046_story and not isNil(var_391_9) then
					arg_388_1.var_.characterEffect6046_story.fillFlat = true
					arg_388_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 0) / var_391_10)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_10 and arg_388_1.time_ < 0 + var_391_10 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect6046_story then
				arg_388_1.var_.characterEffect6046_story.fillFlat = true
				arg_388_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_391_11 = arg_388_1.actors_["1097ui_story"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1097ui_story = var_391_11.localPosition
			end

			local var_391_12 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_12 then
				var_391_11.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_388_1.time_ - 0) / var_391_12)
				var_391_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_11.position).x, (manager.ui.mainCamera.transform.position - var_391_11.position).y, (manager.ui.mainCamera.transform.position - var_391_11.position).z)
				var_391_11.localEulerAngles.z = 0
				var_391_11.localEulerAngles.x = 0
				var_391_11.localEulerAngles = var_391_11.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_12 and arg_388_1.time_ < 0 + var_391_12 + arg_391_0 then
				var_391_11.localPosition = Vector3.New(0, -0.54, -6.3)
				var_391_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_11.position).x, (manager.ui.mainCamera.transform.position - var_391_11.position).y, (manager.ui.mainCamera.transform.position - var_391_11.position).z)
				var_391_11.localEulerAngles.z = 0
				var_391_11.localEulerAngles.x = 0
				var_391_11.localEulerAngles = var_391_11.localEulerAngles
			end

			local var_391_13 = arg_388_1.actors_["1097ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_13) and arg_388_1.var_.characterEffect1097ui_story == nil then
				arg_388_1.var_.characterEffect1097ui_story = var_391_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_14 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_14 and not isNil(var_391_13) then
				if arg_388_1.var_.characterEffect1097ui_story and not isNil(var_391_13) then
					arg_388_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_14 and arg_388_1.time_ < 0 + var_391_14 + arg_391_0 and not isNil(var_391_13) and arg_388_1.var_.characterEffect1097ui_story then
				arg_388_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_391_16 = 0
			local var_391_17 = 0.075

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_18 = arg_388_1:GetWordFromCfg(1109701095)
				local var_391_19 = arg_388_1:FormatText(var_391_18.content)

				arg_388_1.text_.text = var_391_19

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_21 = 3 <= 0 and var_391_17 or var_391_17 * (utf8.len(var_391_19) / 3)

				if (3 <= 0 and var_391_17 or var_391_17 * (utf8.len(var_391_19) / 3)) > 0 and var_391_17 < var_391_21 then
					arg_388_1.talkMaxDuration = var_391_21

					if var_391_21 + var_391_16 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_21 + var_391_16
					end
				end

				arg_388_1.text_.text = var_391_19
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701095", "story_v_side_new_1109701.awb") ~= 0 then
					local var_391_22 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701095", "story_v_side_new_1109701.awb") / 1000

					if var_391_22 + var_391_16 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_22 + var_391_16
					end

					if var_391_18.prefab_name ~= "" and arg_388_1.actors_[var_391_18.prefab_name] ~= nil then
						local var_391_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_18.prefab_name].transform, "story_v_side_new_1109701", "1109701095", "story_v_side_new_1109701.awb")

						arg_388_1:RecordAudio("1109701095", var_391_23)
						arg_388_1:RecordAudio("1109701095", var_391_23)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701095", "story_v_side_new_1109701.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701095", "story_v_side_new_1109701.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_24 = math.max(var_391_17, arg_388_1.talkMaxDuration)

			if var_391_16 <= arg_388_1.time_ and arg_388_1.time_ < var_391_16 + var_391_24 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_16) / var_391_24

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_16 + var_391_24 and arg_388_1.time_ < var_391_16 + var_391_24 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play1109701096 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1109701096
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1109701097(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["1097ui_story"]) and arg_392_1.var_.characterEffect1097ui_story == nil then
				arg_392_1.var_.characterEffect1097ui_story = arg_392_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_0 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["1097ui_story"]) then
				if arg_392_1.var_.characterEffect1097ui_story and not isNil(arg_392_1.actors_["1097ui_story"]) then
					arg_392_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_392_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_392_1.time_ - 0) / var_395_0)
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["1097ui_story"]) and arg_392_1.var_.characterEffect1097ui_story then
				arg_392_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_392_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_395_1 = 0
			local var_395_2 = 0.35

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, false)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_3 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(1109701096).content)

				arg_392_1.text_.text = var_395_3

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 14 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_3) / 14)

				if (14 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_3) / 14)) > 0 and var_395_2 < var_395_5 then
					arg_392_1.talkMaxDuration = var_395_5

					if var_395_5 + var_395_1 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_5 + var_395_1
					end
				end

				arg_392_1.text_.text = var_395_3
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_6 = math.max(var_395_2, arg_392_1.talkMaxDuration)

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_6 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_1) / var_395_6

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_1 + var_395_6 and arg_392_1.time_ < var_395_1 + var_395_6 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play1109701097 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1109701097
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1109701098(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 1.125

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_1 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(1109701097).content)

				arg_396_1.text_.text = var_399_1

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_3 = 47 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 47)

				if (47 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 47)) > 0 and var_399_0 < var_399_3 then
					arg_396_1.talkMaxDuration = var_399_3

					if var_399_3 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_3 + 0
					end
				end

				arg_396_1.text_.text = var_399_1
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_4 = math.max(var_399_0, arg_396_1.talkMaxDuration)

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_4 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - 0) / var_399_4

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= 0 + var_399_4 and arg_396_1.time_ < 0 + var_399_4 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play1109701098 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1109701098
		arg_400_1.duration_ = 5.27

		local var_400_0 = {
			zh = 5.266,
			ja = 4.366
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1109701099(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos1097ui_story = arg_400_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_403_0 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 then
				arg_400_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_400_1.time_ - 0) / var_403_0)
				arg_400_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1097ui_story"].transform.position).z)
				arg_400_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["1097ui_story"].transform.localEulerAngles = arg_400_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 then
				arg_400_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_400_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_400_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_400_1.actors_["1097ui_story"].transform.position).z)
				arg_400_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_400_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_400_1.actors_["1097ui_story"].transform.localEulerAngles = arg_400_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_403_1 = arg_400_1.actors_["1097ui_story"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_1) and arg_400_1.var_.characterEffect1097ui_story == nil then
				arg_400_1.var_.characterEffect1097ui_story = var_403_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_2 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_2 and not isNil(var_403_1) then
				if arg_400_1.var_.characterEffect1097ui_story and not isNil(var_403_1) then
					arg_400_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_400_1.time_ - 0) / var_403_2)
				end
			end

			if arg_400_1.time_ >= 0 + var_403_2 and arg_400_1.time_ < 0 + var_403_2 + arg_403_0 and not isNil(var_403_1) and arg_400_1.var_.characterEffect1097ui_story then
				arg_400_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_403_3 = arg_400_1.actors_["1042ui_story"].transform

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos1042ui_story = var_403_3.localPosition
			end

			local var_403_4 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_4 then
				var_403_3.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_400_1.time_ - 0) / var_403_4)
				var_403_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_403_3.position).x, (manager.ui.mainCamera.transform.position - var_403_3.position).y, (manager.ui.mainCamera.transform.position - var_403_3.position).z)
				var_403_3.localEulerAngles.z = 0
				var_403_3.localEulerAngles.x = 0
				var_403_3.localEulerAngles = var_403_3.localEulerAngles
			end

			if arg_400_1.time_ >= 0 + var_403_4 and arg_400_1.time_ < 0 + var_403_4 + arg_403_0 then
				var_403_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_403_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_403_3.position).x, (manager.ui.mainCamera.transform.position - var_403_3.position).y, (manager.ui.mainCamera.transform.position - var_403_3.position).z)
				var_403_3.localEulerAngles.z = 0
				var_403_3.localEulerAngles.x = 0
				var_403_3.localEulerAngles = var_403_3.localEulerAngles
			end

			local var_403_5 = arg_400_1.actors_["1042ui_story"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_5) and arg_400_1.var_.characterEffect1042ui_story == nil then
				arg_400_1.var_.characterEffect1042ui_story = var_403_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_6 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_6 and not isNil(var_403_5) then
				if arg_400_1.var_.characterEffect1042ui_story and not isNil(var_403_5) then
					arg_400_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 0 + var_403_6 and arg_400_1.time_ < 0 + var_403_6 + arg_403_0 and not isNil(var_403_5) and arg_400_1.var_.characterEffect1042ui_story then
				arg_400_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_403_8 = 0
			local var_403_9 = 0.525

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_8 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_10 = arg_400_1:GetWordFromCfg(1109701098)
				local var_403_11 = arg_400_1:FormatText(var_403_10.content)

				arg_400_1.text_.text = var_403_11

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_13 = 21 <= 0 and var_403_9 or var_403_9 * (utf8.len(var_403_11) / 21)

				if (21 <= 0 and var_403_9 or var_403_9 * (utf8.len(var_403_11) / 21)) > 0 and var_403_9 < var_403_13 then
					arg_400_1.talkMaxDuration = var_403_13

					if var_403_13 + var_403_8 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_13 + var_403_8
					end
				end

				arg_400_1.text_.text = var_403_11
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701098", "story_v_side_new_1109701.awb") ~= 0 then
					local var_403_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701098", "story_v_side_new_1109701.awb") / 1000

					if var_403_14 + var_403_8 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_14 + var_403_8
					end

					if var_403_10.prefab_name ~= "" and arg_400_1.actors_[var_403_10.prefab_name] ~= nil then
						local var_403_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_10.prefab_name].transform, "story_v_side_new_1109701", "1109701098", "story_v_side_new_1109701.awb")

						arg_400_1:RecordAudio("1109701098", var_403_15)
						arg_400_1:RecordAudio("1109701098", var_403_15)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701098", "story_v_side_new_1109701.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701098", "story_v_side_new_1109701.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_16 = math.max(var_403_9, arg_400_1.talkMaxDuration)

			if var_403_8 <= arg_400_1.time_ and arg_400_1.time_ < var_403_8 + var_403_16 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_8) / var_403_16

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_8 + var_403_16 and arg_400_1.time_ < var_403_8 + var_403_16 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play1109701099 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1109701099
		arg_404_1.duration_ = 2

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1109701100(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos1097ui_story = arg_404_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_407_0 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 then
				arg_404_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_404_1.time_ - 0) / var_407_0)
				arg_404_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1097ui_story"].transform.position).z)
				arg_404_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1097ui_story"].transform.localEulerAngles = arg_404_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 then
				arg_404_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_404_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1097ui_story"].transform.position).z)
				arg_404_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1097ui_story"].transform.localEulerAngles = arg_404_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_407_1 = arg_404_1.actors_["1097ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1097ui_story == nil then
				arg_404_1.var_.characterEffect1097ui_story = var_407_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_2 and not isNil(var_407_1) then
				if arg_404_1.var_.characterEffect1097ui_story and not isNil(var_407_1) then
					arg_404_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_2 and arg_404_1.time_ < 0 + var_407_2 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1097ui_story then
				arg_404_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_407_4 = arg_404_1.actors_["1042ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_4) and arg_404_1.var_.characterEffect1042ui_story == nil then
				arg_404_1.var_.characterEffect1042ui_story = var_407_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_5 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_5 and not isNil(var_407_4) then
				if arg_404_1.var_.characterEffect1042ui_story and not isNil(var_407_4) then
					arg_404_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_5)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_5 and arg_404_1.time_ < 0 + var_407_5 + arg_407_0 and not isNil(var_407_4) and arg_404_1.var_.characterEffect1042ui_story then
				arg_404_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_407_6 = 0
			local var_407_7 = 0.05

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_6 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_8 = arg_404_1:GetWordFromCfg(1109701099)
				local var_407_9 = arg_404_1:FormatText(var_407_8.content)

				arg_404_1.text_.text = var_407_9

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_11 = 2 <= 0 and var_407_7 or var_407_7 * (utf8.len(var_407_9) / 2)

				if (2 <= 0 and var_407_7 or var_407_7 * (utf8.len(var_407_9) / 2)) > 0 and var_407_7 < var_407_11 then
					arg_404_1.talkMaxDuration = var_407_11

					if var_407_11 + var_407_6 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_11 + var_407_6
					end
				end

				arg_404_1.text_.text = var_407_9
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701099", "story_v_side_new_1109701.awb") ~= 0 then
					local var_407_12 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701099", "story_v_side_new_1109701.awb") / 1000

					if var_407_12 + var_407_6 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_12 + var_407_6
					end

					if var_407_8.prefab_name ~= "" and arg_404_1.actors_[var_407_8.prefab_name] ~= nil then
						local var_407_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_8.prefab_name].transform, "story_v_side_new_1109701", "1109701099", "story_v_side_new_1109701.awb")

						arg_404_1:RecordAudio("1109701099", var_407_13)
						arg_404_1:RecordAudio("1109701099", var_407_13)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701099", "story_v_side_new_1109701.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701099", "story_v_side_new_1109701.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_14 = math.max(var_407_7, arg_404_1.talkMaxDuration)

			if var_407_6 <= arg_404_1.time_ and arg_404_1.time_ < var_407_6 + var_407_14 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_6) / var_407_14

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_6 + var_407_14 and arg_404_1.time_ < var_407_6 + var_407_14 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play1109701100 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1109701100
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1109701101(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(arg_408_1.actors_["1097ui_story"]) and arg_408_1.var_.characterEffect1097ui_story == nil then
				arg_408_1.var_.characterEffect1097ui_story = arg_408_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_0 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 and not isNil(arg_408_1.actors_["1097ui_story"]) then
				if arg_408_1.var_.characterEffect1097ui_story and not isNil(arg_408_1.actors_["1097ui_story"]) then
					arg_408_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_0)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 and not isNil(arg_408_1.actors_["1097ui_story"]) and arg_408_1.var_.characterEffect1097ui_story then
				arg_408_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_411_1 = 0
			local var_411_2 = 0.475

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_3 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(1109701100).content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 19 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_3) / 19)

				if (19 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_3) / 19)) > 0 and var_411_2 < var_411_5 then
					arg_408_1.talkMaxDuration = var_411_5

					if var_411_5 + var_411_1 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + var_411_1
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_6 = math.max(var_411_2, arg_408_1.talkMaxDuration)

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_6 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_1) / var_411_6

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_1 + var_411_6 and arg_408_1.time_ < var_411_1 + var_411_6 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1109701101 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1109701101
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1109701102(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0.95

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_1 = arg_412_1:FormatText(arg_412_1:GetWordFromCfg(1109701101).content)

				arg_412_1.text_.text = var_415_1

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_3 = 38 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 38)

				if (38 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 38)) > 0 and var_415_0 < var_415_3 then
					arg_412_1.talkMaxDuration = var_415_3

					if var_415_3 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_3 + 0
					end
				end

				arg_412_1.text_.text = var_415_1
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_4 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_4 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_4

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_4 and arg_412_1.time_ < 0 + var_415_4 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1109701102 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1109701102
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1109701103(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.7

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_1 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(1109701102).content)

				arg_416_1.text_.text = var_419_1

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_3 = 28 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 28)

				if (28 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 28)) > 0 and var_419_0 < var_419_3 then
					arg_416_1.talkMaxDuration = var_419_3

					if var_419_3 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_3 + 0
					end
				end

				arg_416_1.text_.text = var_419_1
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_4 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_4

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1109701103 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1109701103
		arg_420_1.duration_ = 4.57

		local var_420_0 = {
			zh = 4.566,
			ja = 3.833
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1109701104(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["1097ui_story"]) and arg_420_1.var_.characterEffect1097ui_story == nil then
				arg_420_1.var_.characterEffect1097ui_story = arg_420_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_0 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["1097ui_story"]) then
				if arg_420_1.var_.characterEffect1097ui_story and not isNil(arg_420_1.actors_["1097ui_story"]) then
					arg_420_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["1097ui_story"]) and arg_420_1.var_.characterEffect1097ui_story then
				arg_420_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_423_2 = 0
			local var_423_3 = 0.35

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_2 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_4 = arg_420_1:GetWordFromCfg(1109701103)
				local var_423_5 = arg_420_1:FormatText(var_423_4.content)

				arg_420_1.text_.text = var_423_5

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_7 = 14 <= 0 and var_423_3 or var_423_3 * (utf8.len(var_423_5) / 14)

				if (14 <= 0 and var_423_3 or var_423_3 * (utf8.len(var_423_5) / 14)) > 0 and var_423_3 < var_423_7 then
					arg_420_1.talkMaxDuration = var_423_7

					if var_423_7 + var_423_2 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_7 + var_423_2
					end
				end

				arg_420_1.text_.text = var_423_5
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701103", "story_v_side_new_1109701.awb") ~= 0 then
					local var_423_8 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701103", "story_v_side_new_1109701.awb") / 1000

					if var_423_8 + var_423_2 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_8 + var_423_2
					end

					if var_423_4.prefab_name ~= "" and arg_420_1.actors_[var_423_4.prefab_name] ~= nil then
						local var_423_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_4.prefab_name].transform, "story_v_side_new_1109701", "1109701103", "story_v_side_new_1109701.awb")

						arg_420_1:RecordAudio("1109701103", var_423_9)
						arg_420_1:RecordAudio("1109701103", var_423_9)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701103", "story_v_side_new_1109701.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701103", "story_v_side_new_1109701.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_10 = math.max(var_423_3, arg_420_1.talkMaxDuration)

			if var_423_2 <= arg_420_1.time_ and arg_420_1.time_ < var_423_2 + var_423_10 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_2) / var_423_10

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_2 + var_423_10 and arg_420_1.time_ < var_423_2 + var_423_10 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1109701104 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1109701104
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1109701105(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(arg_424_1.actors_["1097ui_story"]) and arg_424_1.var_.characterEffect1097ui_story == nil then
				arg_424_1.var_.characterEffect1097ui_story = arg_424_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_0 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 and not isNil(arg_424_1.actors_["1097ui_story"]) then
				if arg_424_1.var_.characterEffect1097ui_story and not isNil(arg_424_1.actors_["1097ui_story"]) then
					arg_424_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_0)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 and not isNil(arg_424_1.actors_["1097ui_story"]) and arg_424_1.var_.characterEffect1097ui_story then
				arg_424_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_427_1 = 0
			local var_427_2 = 0.325

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_3 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(1109701104).content)

				arg_424_1.text_.text = var_427_3

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 13 <= 0 and var_427_2 or var_427_2 * (utf8.len(var_427_3) / 13)

				if (13 <= 0 and var_427_2 or var_427_2 * (utf8.len(var_427_3) / 13)) > 0 and var_427_2 < var_427_5 then
					arg_424_1.talkMaxDuration = var_427_5

					if var_427_5 + var_427_1 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_5 + var_427_1
					end
				end

				arg_424_1.text_.text = var_427_3
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_6 = math.max(var_427_2, arg_424_1.talkMaxDuration)

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_6 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_1) / var_427_6

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_1 + var_427_6 and arg_424_1.time_ < var_427_1 + var_427_6 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1109701105 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1109701105
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1109701106(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0.425

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_1 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(1109701105).content)

				arg_428_1.text_.text = var_431_1

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_3 = 17 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 17)

				if (17 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 17)) > 0 and var_431_0 < var_431_3 then
					arg_428_1.talkMaxDuration = var_431_3

					if var_431_3 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_3 + 0
					end
				end

				arg_428_1.text_.text = var_431_1
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_4 = math.max(var_431_0, arg_428_1.talkMaxDuration)

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_4 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - 0) / var_431_4

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= 0 + var_431_4 and arg_428_1.time_ < 0 + var_431_4 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1109701106 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1109701106
		arg_432_1.duration_ = 8.13

		local var_432_0 = {
			zh = 4.7,
			ja = 8.133
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1109701107(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["1097ui_story"]) and arg_432_1.var_.characterEffect1097ui_story == nil then
				arg_432_1.var_.characterEffect1097ui_story = arg_432_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_0 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["1097ui_story"]) then
				if arg_432_1.var_.characterEffect1097ui_story and not isNil(arg_432_1.actors_["1097ui_story"]) then
					arg_432_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["1097ui_story"]) and arg_432_1.var_.characterEffect1097ui_story then
				arg_432_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_435_2 = 0
			local var_435_3 = 0.375

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_2 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_4 = arg_432_1:GetWordFromCfg(1109701106)
				local var_435_5 = arg_432_1:FormatText(var_435_4.content)

				arg_432_1.text_.text = var_435_5

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_7 = 15 <= 0 and var_435_3 or var_435_3 * (utf8.len(var_435_5) / 15)

				if (15 <= 0 and var_435_3 or var_435_3 * (utf8.len(var_435_5) / 15)) > 0 and var_435_3 < var_435_7 then
					arg_432_1.talkMaxDuration = var_435_7

					if var_435_7 + var_435_2 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_2
					end
				end

				arg_432_1.text_.text = var_435_5
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701106", "story_v_side_new_1109701.awb") ~= 0 then
					local var_435_8 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701106", "story_v_side_new_1109701.awb") / 1000

					if var_435_8 + var_435_2 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_8 + var_435_2
					end

					if var_435_4.prefab_name ~= "" and arg_432_1.actors_[var_435_4.prefab_name] ~= nil then
						local var_435_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_4.prefab_name].transform, "story_v_side_new_1109701", "1109701106", "story_v_side_new_1109701.awb")

						arg_432_1:RecordAudio("1109701106", var_435_9)
						arg_432_1:RecordAudio("1109701106", var_435_9)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701106", "story_v_side_new_1109701.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701106", "story_v_side_new_1109701.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_10 = math.max(var_435_3, arg_432_1.talkMaxDuration)

			if var_435_2 <= arg_432_1.time_ and arg_432_1.time_ < var_435_2 + var_435_10 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_2) / var_435_10

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_2 + var_435_10 and arg_432_1.time_ < var_435_2 + var_435_10 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1109701107 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1109701107
		arg_436_1.duration_ = 6.83

		local var_436_0 = {
			zh = 6.233,
			ja = 6.833
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1109701108(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_439_0 = 0
			local var_439_1 = 0.5

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_2 = arg_436_1:GetWordFromCfg(1109701107)
				local var_439_3 = arg_436_1:FormatText(var_439_2.content)

				arg_436_1.text_.text = var_439_3

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_5 = 20 <= 0 and var_439_1 or var_439_1 * (utf8.len(var_439_3) / 20)

				if (20 <= 0 and var_439_1 or var_439_1 * (utf8.len(var_439_3) / 20)) > 0 and var_439_1 < var_439_5 then
					arg_436_1.talkMaxDuration = var_439_5

					if var_439_5 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_5 + var_439_0
					end
				end

				arg_436_1.text_.text = var_439_3
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701107", "story_v_side_new_1109701.awb") ~= 0 then
					local var_439_6 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701107", "story_v_side_new_1109701.awb") / 1000

					if var_439_6 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_6 + var_439_0
					end

					if var_439_2.prefab_name ~= "" and arg_436_1.actors_[var_439_2.prefab_name] ~= nil then
						local var_439_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_2.prefab_name].transform, "story_v_side_new_1109701", "1109701107", "story_v_side_new_1109701.awb")

						arg_436_1:RecordAudio("1109701107", var_439_7)
						arg_436_1:RecordAudio("1109701107", var_439_7)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701107", "story_v_side_new_1109701.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701107", "story_v_side_new_1109701.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_8 = math.max(var_439_1, arg_436_1.talkMaxDuration)

			if var_439_0 <= arg_436_1.time_ and arg_436_1.time_ < var_439_0 + var_439_8 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_0) / var_439_8

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_0 + var_439_8 and arg_436_1.time_ < var_439_0 + var_439_8 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1109701108 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1109701108
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1109701109(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(arg_440_1.actors_["1097ui_story"]) and arg_440_1.var_.characterEffect1097ui_story == nil then
				arg_440_1.var_.characterEffect1097ui_story = arg_440_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_0 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 and not isNil(arg_440_1.actors_["1097ui_story"]) then
				if arg_440_1.var_.characterEffect1097ui_story and not isNil(arg_440_1.actors_["1097ui_story"]) then
					arg_440_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_440_1.time_ - 0) / var_443_0)
				end
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 and not isNil(arg_440_1.actors_["1097ui_story"]) and arg_440_1.var_.characterEffect1097ui_story then
				arg_440_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_443_1 = 0
			local var_443_2 = 0.1

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_3 = arg_440_1:FormatText(arg_440_1:GetWordFromCfg(1109701108).content)

				arg_440_1.text_.text = var_443_3

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 4 <= 0 and var_443_2 or var_443_2 * (utf8.len(var_443_3) / 4)

				if (4 <= 0 and var_443_2 or var_443_2 * (utf8.len(var_443_3) / 4)) > 0 and var_443_2 < var_443_5 then
					arg_440_1.talkMaxDuration = var_443_5

					if var_443_5 + var_443_1 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + var_443_1
					end
				end

				arg_440_1.text_.text = var_443_3
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_6 = math.max(var_443_2, arg_440_1.talkMaxDuration)

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_6 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_1) / var_443_6

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_1 + var_443_6 and arg_440_1.time_ < var_443_1 + var_443_6 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play1109701109 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1109701109
		arg_444_1.duration_ = 5.9

		local var_444_0 = {
			zh = 5.533,
			ja = 5.9
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1109701110(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos1042ui_story = arg_444_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_447_0 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 then
				arg_444_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_444_1.time_ - 0) / var_447_0)
				arg_444_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1042ui_story"].transform.position).z)
				arg_444_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1042ui_story"].transform.localEulerAngles = arg_444_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 then
				arg_444_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_444_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1042ui_story"].transform.position).z)
				arg_444_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1042ui_story"].transform.localEulerAngles = arg_444_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_447_1 = arg_444_1.actors_["1042ui_story"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_1) and arg_444_1.var_.characterEffect1042ui_story == nil then
				arg_444_1.var_.characterEffect1042ui_story = var_447_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_2 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_2 and not isNil(var_447_1) then
				if arg_444_1.var_.characterEffect1042ui_story and not isNil(var_447_1) then
					arg_444_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= 0 + var_447_2 and arg_444_1.time_ < 0 + var_447_2 + arg_447_0 and not isNil(var_447_1) and arg_444_1.var_.characterEffect1042ui_story then
				arg_444_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_447_4 = 0
			local var_447_5 = 0.6

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_4 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_6 = arg_444_1:GetWordFromCfg(1109701109)
				local var_447_7 = arg_444_1:FormatText(var_447_6.content)

				arg_444_1.text_.text = var_447_7

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_9 = 24 <= 0 and var_447_5 or var_447_5 * (utf8.len(var_447_7) / 24)

				if (24 <= 0 and var_447_5 or var_447_5 * (utf8.len(var_447_7) / 24)) > 0 and var_447_5 < var_447_9 then
					arg_444_1.talkMaxDuration = var_447_9

					if var_447_9 + var_447_4 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_9 + var_447_4
					end
				end

				arg_444_1.text_.text = var_447_7
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701109", "story_v_side_new_1109701.awb") ~= 0 then
					local var_447_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701109", "story_v_side_new_1109701.awb") / 1000

					if var_447_10 + var_447_4 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_10 + var_447_4
					end

					if var_447_6.prefab_name ~= "" and arg_444_1.actors_[var_447_6.prefab_name] ~= nil then
						local var_447_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_6.prefab_name].transform, "story_v_side_new_1109701", "1109701109", "story_v_side_new_1109701.awb")

						arg_444_1:RecordAudio("1109701109", var_447_11)
						arg_444_1:RecordAudio("1109701109", var_447_11)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701109", "story_v_side_new_1109701.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701109", "story_v_side_new_1109701.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_12 = math.max(var_447_5, arg_444_1.talkMaxDuration)

			if var_447_4 <= arg_444_1.time_ and arg_444_1.time_ < var_447_4 + var_447_12 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_4) / var_447_12

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_4 + var_447_12 and arg_444_1.time_ < var_447_4 + var_447_12 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play1109701110 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1109701110
		arg_448_1.duration_ = 5.2

		local var_448_0 = {
			zh = 4.1,
			ja = 5.2
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1109701111(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_451_0 = 0
			local var_451_1 = 0.45

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_2 = arg_448_1:GetWordFromCfg(1109701110)
				local var_451_3 = arg_448_1:FormatText(var_451_2.content)

				arg_448_1.text_.text = var_451_3

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 18 <= 0 and var_451_1 or var_451_1 * (utf8.len(var_451_3) / 18)

				if (18 <= 0 and var_451_1 or var_451_1 * (utf8.len(var_451_3) / 18)) > 0 and var_451_1 < var_451_5 then
					arg_448_1.talkMaxDuration = var_451_5

					if var_451_5 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_5 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_3
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701110", "story_v_side_new_1109701.awb") ~= 0 then
					local var_451_6 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701110", "story_v_side_new_1109701.awb") / 1000

					if var_451_6 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_6 + var_451_0
					end

					if var_451_2.prefab_name ~= "" and arg_448_1.actors_[var_451_2.prefab_name] ~= nil then
						local var_451_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_2.prefab_name].transform, "story_v_side_new_1109701", "1109701110", "story_v_side_new_1109701.awb")

						arg_448_1:RecordAudio("1109701110", var_451_7)
						arg_448_1:RecordAudio("1109701110", var_451_7)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701110", "story_v_side_new_1109701.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701110", "story_v_side_new_1109701.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_8 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_8 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_8

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_8 and arg_448_1.time_ < var_451_0 + var_451_8 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play1109701111 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1109701111
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1109701112(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["1042ui_story"]) and arg_452_1.var_.characterEffect1042ui_story == nil then
				arg_452_1.var_.characterEffect1042ui_story = arg_452_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_0 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["1042ui_story"]) then
				if arg_452_1.var_.characterEffect1042ui_story and not isNil(arg_452_1.actors_["1042ui_story"]) then
					arg_452_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_452_1.time_ - 0) / var_455_0)
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["1042ui_story"]) and arg_452_1.var_.characterEffect1042ui_story then
				arg_452_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_455_1 = 0
			local var_455_2 = 0.075

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_3 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(1109701111).content)

				arg_452_1.text_.text = var_455_3

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 3 <= 0 and var_455_2 or var_455_2 * (utf8.len(var_455_3) / 3)

				if (3 <= 0 and var_455_2 or var_455_2 * (utf8.len(var_455_3) / 3)) > 0 and var_455_2 < var_455_5 then
					arg_452_1.talkMaxDuration = var_455_5

					if var_455_5 + var_455_1 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_5 + var_455_1
					end
				end

				arg_452_1.text_.text = var_455_3
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_6 = math.max(var_455_2, arg_452_1.talkMaxDuration)

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_6 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_1) / var_455_6

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_1 + var_455_6 and arg_452_1.time_ < var_455_1 + var_455_6 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play1109701112 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1109701112
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1109701113(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos1042ui_story = arg_456_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_459_0 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 then
				arg_456_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_456_1.time_ - 0) / var_459_0)
				arg_456_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1042ui_story"].transform.position).z)
				arg_456_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["1042ui_story"].transform.localEulerAngles = arg_456_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 then
				arg_456_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_456_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1042ui_story"].transform.position).z)
				arg_456_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["1042ui_story"].transform.localEulerAngles = arg_456_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_459_1 = arg_456_1.actors_["1097ui_story"].transform

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos1097ui_story = var_459_1.localPosition
			end

			local var_459_2 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_2 then
				var_459_1.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_456_1.time_ - 0) / var_459_2)
				var_459_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_459_1.position).x, (manager.ui.mainCamera.transform.position - var_459_1.position).y, (manager.ui.mainCamera.transform.position - var_459_1.position).z)
				var_459_1.localEulerAngles.z = 0
				var_459_1.localEulerAngles.x = 0
				var_459_1.localEulerAngles = var_459_1.localEulerAngles
			end

			if arg_456_1.time_ >= 0 + var_459_2 and arg_456_1.time_ < 0 + var_459_2 + arg_459_0 then
				var_459_1.localPosition = Vector3.New(0, -0.54, -6.3)
				var_459_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_459_1.position).x, (manager.ui.mainCamera.transform.position - var_459_1.position).y, (manager.ui.mainCamera.transform.position - var_459_1.position).z)
				var_459_1.localEulerAngles.z = 0
				var_459_1.localEulerAngles.x = 0
				var_459_1.localEulerAngles = var_459_1.localEulerAngles
			end

			local var_459_3 = arg_456_1.actors_["1097ui_story"]

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(var_459_3) and arg_456_1.var_.characterEffect1097ui_story == nil then
				arg_456_1.var_.characterEffect1097ui_story = var_459_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_4 = 0.034000001847744

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 and not isNil(var_459_3) then
				if arg_456_1.var_.characterEffect1097ui_story and not isNil(var_459_3) then
					arg_456_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_456_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_456_1.time_ - 0) / var_459_4)
				end
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 and not isNil(var_459_3) and arg_456_1.var_.characterEffect1097ui_story then
				arg_456_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_456_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_459_5 = 0
			local var_459_6 = 0.85

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_5 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_7 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(1109701112).content)

				arg_456_1.text_.text = var_459_7

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_9 = 34 <= 0 and var_459_6 or var_459_6 * (utf8.len(var_459_7) / 34)

				if (34 <= 0 and var_459_6 or var_459_6 * (utf8.len(var_459_7) / 34)) > 0 and var_459_6 < var_459_9 then
					arg_456_1.talkMaxDuration = var_459_9

					if var_459_9 + var_459_5 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_9 + var_459_5
					end
				end

				arg_456_1.text_.text = var_459_7
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_10 = math.max(var_459_6, arg_456_1.talkMaxDuration)

			if var_459_5 <= arg_456_1.time_ and arg_456_1.time_ < var_459_5 + var_459_10 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_5) / var_459_10

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_5 + var_459_10 and arg_456_1.time_ < var_459_5 + var_459_10 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play1109701113 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1109701113
		arg_460_1.duration_ = 3.3

		local var_460_0 = {
			zh = 3.3,
			ja = 3
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1109701114(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(arg_460_1.actors_["1097ui_story"]) and arg_460_1.var_.characterEffect1097ui_story == nil then
				arg_460_1.var_.characterEffect1097ui_story = arg_460_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_0 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 and not isNil(arg_460_1.actors_["1097ui_story"]) then
				if arg_460_1.var_.characterEffect1097ui_story and not isNil(arg_460_1.actors_["1097ui_story"]) then
					arg_460_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 and not isNil(arg_460_1.actors_["1097ui_story"]) and arg_460_1.var_.characterEffect1097ui_story then
				arg_460_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_463_2 = 0
			local var_463_3 = 0.525

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_2 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_4 = arg_460_1:GetWordFromCfg(1109701113)
				local var_463_5 = arg_460_1:FormatText(var_463_4.content)

				arg_460_1.text_.text = var_463_5

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_7 = 21 <= 0 and var_463_3 or var_463_3 * (utf8.len(var_463_5) / 21)

				if (21 <= 0 and var_463_3 or var_463_3 * (utf8.len(var_463_5) / 21)) > 0 and var_463_3 < var_463_7 then
					arg_460_1.talkMaxDuration = var_463_7

					if var_463_7 + var_463_2 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_7 + var_463_2
					end
				end

				arg_460_1.text_.text = var_463_5
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701113", "story_v_side_new_1109701.awb") ~= 0 then
					local var_463_8 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701113", "story_v_side_new_1109701.awb") / 1000

					if var_463_8 + var_463_2 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_8 + var_463_2
					end

					if var_463_4.prefab_name ~= "" and arg_460_1.actors_[var_463_4.prefab_name] ~= nil then
						local var_463_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_4.prefab_name].transform, "story_v_side_new_1109701", "1109701113", "story_v_side_new_1109701.awb")

						arg_460_1:RecordAudio("1109701113", var_463_9)
						arg_460_1:RecordAudio("1109701113", var_463_9)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701113", "story_v_side_new_1109701.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701113", "story_v_side_new_1109701.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_10 = math.max(var_463_3, arg_460_1.talkMaxDuration)

			if var_463_2 <= arg_460_1.time_ and arg_460_1.time_ < var_463_2 + var_463_10 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_2) / var_463_10

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_2 + var_463_10 and arg_460_1.time_ < var_463_2 + var_463_10 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1109701114 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1109701114
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1109701115(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["1097ui_story"]) and arg_464_1.var_.characterEffect1097ui_story == nil then
				arg_464_1.var_.characterEffect1097ui_story = arg_464_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_0 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["1097ui_story"]) then
				if arg_464_1.var_.characterEffect1097ui_story and not isNil(arg_464_1.actors_["1097ui_story"]) then
					arg_464_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_464_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_464_1.time_ - 0) / var_467_0)
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["1097ui_story"]) and arg_464_1.var_.characterEffect1097ui_story then
				arg_464_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_464_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_467_1 = 0
			local var_467_2 = 0.325

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_3 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(1109701114).content)

				arg_464_1.text_.text = var_467_3

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 13 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 13)

				if (13 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 13)) > 0 and var_467_2 < var_467_5 then
					arg_464_1.talkMaxDuration = var_467_5

					if var_467_5 + var_467_1 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_5 + var_467_1
					end
				end

				arg_464_1.text_.text = var_467_3
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_6 = math.max(var_467_2, arg_464_1.talkMaxDuration)

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_6 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_1) / var_467_6

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_1 + var_467_6 and arg_464_1.time_ < var_467_1 + var_467_6 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1109701115 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1109701115
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1109701116(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0.8

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_1 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(1109701115).content)

				arg_468_1.text_.text = var_471_1

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_3 = 32 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 32)

				if (32 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 32)) > 0 and var_471_0 < var_471_3 then
					arg_468_1.talkMaxDuration = var_471_3

					if var_471_3 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_3 + 0
					end
				end

				arg_468_1.text_.text = var_471_1
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_4 = math.max(var_471_0, arg_468_1.talkMaxDuration)

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_4 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - 0) / var_471_4

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= 0 + var_471_4 and arg_468_1.time_ < 0 + var_471_4 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1109701116 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1109701116
		arg_472_1.duration_ = 4

		local var_472_0 = {
			zh = 3.1,
			ja = 4
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1109701117(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.var_.moveOldPos1097ui_story = arg_472_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_475_0 = 0.001

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 then
				arg_472_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_472_1.time_ - 0) / var_475_0)
				arg_472_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1097ui_story"].transform.position).z)
				arg_472_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["1097ui_story"].transform.localEulerAngles = arg_472_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 then
				arg_472_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_472_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1097ui_story"].transform.position).z)
				arg_472_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["1097ui_story"].transform.localEulerAngles = arg_472_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_475_1 = arg_472_1.actors_["1097ui_story"]

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(var_475_1) and arg_472_1.var_.characterEffect1097ui_story == nil then
				arg_472_1.var_.characterEffect1097ui_story = var_475_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_2 = 0.200000002980232

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_2 and not isNil(var_475_1) then
				if arg_472_1.var_.characterEffect1097ui_story and not isNil(var_475_1) then
					arg_472_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= 0 + var_475_2 and arg_472_1.time_ < 0 + var_475_2 + arg_475_0 and not isNil(var_475_1) and arg_472_1.var_.characterEffect1097ui_story then
				arg_472_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_475_4 = 0
			local var_475_5 = 0.45

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_4 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_6 = arg_472_1:GetWordFromCfg(1109701116)
				local var_475_7 = arg_472_1:FormatText(var_475_6.content)

				arg_472_1.text_.text = var_475_7

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_9 = 18 <= 0 and var_475_5 or var_475_5 * (utf8.len(var_475_7) / 18)

				if (18 <= 0 and var_475_5 or var_475_5 * (utf8.len(var_475_7) / 18)) > 0 and var_475_5 < var_475_9 then
					arg_472_1.talkMaxDuration = var_475_9

					if var_475_9 + var_475_4 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_9 + var_475_4
					end
				end

				arg_472_1.text_.text = var_475_7
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701116", "story_v_side_new_1109701.awb") ~= 0 then
					local var_475_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701116", "story_v_side_new_1109701.awb") / 1000

					if var_475_10 + var_475_4 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_10 + var_475_4
					end

					if var_475_6.prefab_name ~= "" and arg_472_1.actors_[var_475_6.prefab_name] ~= nil then
						local var_475_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_6.prefab_name].transform, "story_v_side_new_1109701", "1109701116", "story_v_side_new_1109701.awb")

						arg_472_1:RecordAudio("1109701116", var_475_11)
						arg_472_1:RecordAudio("1109701116", var_475_11)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701116", "story_v_side_new_1109701.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701116", "story_v_side_new_1109701.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_12 = math.max(var_475_5, arg_472_1.talkMaxDuration)

			if var_475_4 <= arg_472_1.time_ and arg_472_1.time_ < var_475_4 + var_475_12 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_4) / var_475_12

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_4 + var_475_12 and arg_472_1.time_ < var_475_4 + var_475_12 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play1109701117 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1109701117
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1109701118(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(arg_476_1.actors_["1097ui_story"]) and arg_476_1.var_.characterEffect1097ui_story == nil then
				arg_476_1.var_.characterEffect1097ui_story = arg_476_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_0 = 0.200000002980232

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_0 and not isNil(arg_476_1.actors_["1097ui_story"]) then
				if arg_476_1.var_.characterEffect1097ui_story and not isNil(arg_476_1.actors_["1097ui_story"]) then
					arg_476_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_476_1.time_ - 0) / var_479_0)
				end
			end

			if arg_476_1.time_ >= 0 + var_479_0 and arg_476_1.time_ < 0 + var_479_0 + arg_479_0 and not isNil(arg_476_1.actors_["1097ui_story"]) and arg_476_1.var_.characterEffect1097ui_story then
				arg_476_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_479_1 = 0
			local var_479_2 = 0.075

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_3 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(1109701117).content)

				arg_476_1.text_.text = var_479_3

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 3 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 3)

				if (3 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 3)) > 0 and var_479_2 < var_479_5 then
					arg_476_1.talkMaxDuration = var_479_5

					if var_479_5 + var_479_1 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + var_479_1
					end
				end

				arg_476_1.text_.text = var_479_3
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_6 = math.max(var_479_2, arg_476_1.talkMaxDuration)

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_6 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_1) / var_479_6

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_1 + var_479_6 and arg_476_1.time_ < var_479_1 + var_479_6 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1109701118 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1109701118
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
			arg_480_1.auto_ = false
		end

		function arg_480_1.playNext_(arg_482_0)
			arg_480_1.onStoryFinished_()
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0.7

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_1 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(1109701118).content)

				arg_480_1.text_.text = var_483_1

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_3 = 28 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 28)

				if (28 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 28)) > 0 and var_483_0 < var_483_3 then
					arg_480_1.talkMaxDuration = var_483_3

					if var_483_3 + 0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_3 + 0
					end
				end

				arg_480_1.text_.text = var_483_1
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_4 = math.max(var_483_0, arg_480_1.talkMaxDuration)

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_4 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - 0) / var_483_4

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= 0 + var_483_4 and arg_480_1.time_ < 0 + var_483_4 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/F01"
	},
	voices = {
		"story_v_side_new_1109701.awb"
	}
}
